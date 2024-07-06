tput setaf 1 ; echo "Prune..."
kubectl delete -f ../confs/argo.yml
kubectl delete -f ../confs/service.yml
kubectl delete -f ../confs/deployment.yml
kubectl delete -f ../confs/secret.yml
kubectl delete ns argocd > /dev/null
kubectl delete ns gitlab > /dev/null
k3d cluster delete p3