sh script/setup.sh
sleep 1
tput setaf 2 ; echo "Change the service of Argo-cd to Node Port." 
kubectl patch service argocd-server -n argocd --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]' > /dev/null
sleep 2
tput setaf 2 ; echo "apply deployment ..."
kubectl apply -f conf/deployment.yml > /dev/null
tput setaf 2 ; echo "apply argo deployment ..."
kubectl apply -f conf/argo.yml > /dev/null
tput setaf 2 ; echo "apply service ..."
kubectl apply -f conf/service.yml > /dev/null 
sleep 30
tput setaf 2 ; echo "Forwarding connection from your local machine to the Argo CD server running in the Kubernetes cluster. "
kubectl port-forward -n argocd svc/argocd-server 9000:443 > /dev/null