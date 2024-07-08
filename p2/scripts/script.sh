#Install k3s
masterIP="192.168.56.110"
# k3sTokenFile="/var/lib/rancher/k3s/server/node-token"
flags="--tls-san $masterIP --node-external-ip $masterIP"
curl -sfL https://get.k3s.io |  INSTALL_K3S_EXEC="$flags" K3S_NODE_NAME="anassifS" K3S_KUBECONFIG_MODE="644" sh -



#Wait for k3s to be ready
sleep 30
#Apply Kubernetes manifests
kubectl apply -f /vagrant/confs/apps/app1.yaml
kubectl apply -f /vagrant/confs/apps/app2.yaml
kubectl apply -f /vagrant/confs/apps/app3.yaml

#Install Nginx Ingress Controller (ingress is an 
#API object that helps developers expose their applications and manage external 
#access by providing http/s routing rules to the services within a Kubernetes cluster.)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/baremetal/deploy.yaml

#fixed Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

#Apply Ingress resource]
tput setaf 2 ; echo "applying ingress..."
kubectl apply -f /vagrant/confs/apps/ingress.yaml

echo "Waiting for ingress to become ready..."
while true; do
    READY=$(kubectl get ingress web-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    if [[ -n "$READY" ]]; then
        echo "Ingress is ready with IP: $READY"
        break
    fi
    sleep 20
done

echo "Ingress is successfully created and ready!"

#net tools for ifconfig command not available in 20.04
wget http://archive.ubuntu.com/ubuntu/pool/main/n/net-tools/net-tools_1.60+git20161116.90da8a0-1ubuntu1_amd64.deb

dpkg-deb -x net-tools_1.60+git20161116.90da8a0-1ubuntu1_amd64.deb net-tools

sudo cp net-tools/sbin/ifconfig /usr/local/bin/

#sleep 300
