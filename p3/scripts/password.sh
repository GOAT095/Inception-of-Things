# get password login of admin panel (argoCD UI)
sudo chmod -R 777 $HOME/.kube/config
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d