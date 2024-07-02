tput setaf 1 ; echo "Prune..."
kubectl delete -f ../conf/argo.yml
kubectl delete -f ../conf/service.yml
kubectl delete -f ../conf/deployment.yml
kubectl delete ns argocd > /dev/null
kubectl delete ns dev > /dev/null
k3d cluster delete p3