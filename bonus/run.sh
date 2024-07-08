if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with sudo."
    exit 1
fi

gitlab_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gitlab)

echo "The IP address of the container is: $gitlab_ip"

sh ./scripts/setup.sh
sleep 1

# sudo chmod -R 777 $HOME/.kube/config

echo "$(tput setaf 2)Change the service of Argo-cd to Node Port."
kubectl patch service argocd-server -n argocd --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]' > /dev/null
sleep 2

# Apply deployment
echo "$(tput setaf 2)Apply deployment ..."
kubectl apply -f confs/deployment.yml > /dev/null

# Apply Argo application
echo "$(tput setaf 2)Apply Argo application ..."
kubectl apply -f confs/argo.yml > /dev/null

# Apply Secret
echo "$(tput setaf 2)Apply secret ..."
kubectl apply -f confs/secret.yml > /dev/null
sleep 30

# Apply service
echo "$(tput setaf 2)Apply service ..."
kubectl apply -f confs/service.yml > /dev/null
sleep 30

# Find and store the Argo CD server pod name dynamically
ARGOCD_SERVER_POD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')

if [ -z "$ARGOCD_SERVER_POD" ]; then
    echo "$(tput setaf 1)Error: Argo CD server pod not found."
    exit 1
fi

# Port forwarding
echo "$(tput setaf 2)Forwarding connection from your local machine to the Argo CD server running in the Kubernetes cluster..."
kubectl port-forward -n argocd "pod/$ARGOCD_SERVER_POD" 9000:8080 > /dev/null &
PORT_FORWARD_PID=$!

# Function to trap CTRL+C and kill port forwarding
trap ctrl_c INT
function ctrl_c() {
    kill $PORT_FORWARD_PID
    echo "$(tput setaf 2)Stopping port forwarding..."
    cd scripts && bash delete.sh
    exit 0
}

# Wait for port forwarding to be established
sleep 5

echo "$(tput setaf 2)Port forwarding established. Access Argo CD at http://localhost:9000 | login : admin | password : $(sudo bash ./scripts/password.sh)"

# Keep scripts running until interrupted
while true; do
    sleep 1
done