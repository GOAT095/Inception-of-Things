#Install k3s
masterIP="192.168.56.110"
# k3sTokenFile="/var/lib/rancher/k3s/server/node-token"
flags="--tls-san $masterIP --node-external-ip $masterIP" 
curl -sfL https://get.k3s.io |  INSTALL_K3S_EXEC="$flags" K3S_NODE_NAME="anassifS" K3S_KUBECONFIG_MODE="644" sh -



#Wait for k3s to be ready
sleep 30
#Apply Kubernetes manifests
kubectl apply -f /vagrant/apps/app1.yaml
kubectl apply -f /vagrant/apps/app2.yaml
kubectl apply -f /vagrant/apps/app3.yaml

#Install Nginx Ingress Controller (ingress is an 
#API object that helps developers expose their applications and manage external 
#access by providing http/s routing rules to the services within a Kubernetes cluster.)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/baremetal/deploy.yaml

#fixed Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

#Apply Ingress resource]
kubectl apply -f /vagrant/apps/ingress.yaml