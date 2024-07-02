#!/bin/bash
if which k3d;then
    tput setaf 2; echo "K3d is already installed"
else
    tput setaf 2; echo "K3d is instalation..."
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash > /dev/null
fi

sleep 1

tput setaf 2; echo "Creation cluster with K3d"
k3d cluster create p3 -p "8081:30001@agent:0" --agents 1 > /dev/null

sleep 1

tput setaf 2; echo "Creation namespaces"
kubectl create ns argocd > /dev/null
kubectl create ns dev > /dev/null
tput setaf 2; echo "there is two namespaces argocd and dev"

sleep 1

tput setaf 2; echo "Installation of Argo Cd inside arcocd namespace"
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd > /dev/null
sleep 4m
tput setaf 2; echo "Installation success!"
