#Install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip 192.168.42.110" K3S_KUBECONFIG_MODE="644" sh -
#Wait for k3s to be ready
sleep 30

#Apply Kubernetes manifests
kubectl apply -f /vagrant/apps/app1.yaml
kubectl apply -f /vagrant/apps/app2.yaml
kubectl apply -f /vagrant/apps/app3.yaml

#Install Nginx Ingress Controller (ingress is an 
#API object that helps developers expose their applications and manage external 
#access by providing http/s routing rules to the services within a Kubernetes cluster.)
#also using nginx ingress controller is better since traefik apparently can cause problems
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/baremetal/deploy.yaml

#test
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

#Apply Ingress resource
kubectl apply -f /vagrant/apps/ingress.yaml