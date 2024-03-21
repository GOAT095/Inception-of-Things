#Install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip 192.168.42.110" K3S_KUBECONFIG_MODE="644" sh -
#Wait for k3s to be ready
sleep 30

#Apply Kubernetes manifests
kubectl apply -f apps/app1.yaml
kubectl apply -f apps/app2.yaml
kubectl apply -f apps/app3.yaml

#Install Nginx Ingress Controller (ingress is an 
#API object that helps developers expose their applications and manage external 
#access by providing http/s routing rules to the services within a Kubernetes cluster.)
#also using nginx ingress is better since traefik apparently can cause problems
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/baremetal/deploy.yaml

#Apply Ingress resource
kubectl apply -f apps/ingress.yaml