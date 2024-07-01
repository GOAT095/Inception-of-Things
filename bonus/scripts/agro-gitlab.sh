#!/bin/bash

HOST_IP=$(hostname -I | cut -d " " -f1)

k3d cluster edit k3s-default --port-add 8080:8080@loadbalancer
kubectl create namespace gitlab
tput setaf 2 ; echo "create namespace gitlab"

tput setaf 2 ; echo "installing project to argocd..."
sed "s/HOST_IP/$HOST_IP/g" ../confs/project.yaml > /tmp/project.yaml
kubectl apply -f /tmp/project.yaml -n argocd
sleep 3
tput setaf 2 ; echo "project to argocd installed..."

tput setaf 2 ; echo "installing application to argocd..."
sed "s/HOST_IP/$HOST_IP/g" ../confs/application.yaml > /tmp/application.yaml
kubectl apply -f /tmp/application.yaml -n argocd
sleep 3
tput setaf 2 ; echo "application to argocd installed..."

tput setaf 2 ; echo "########## BONUS DONE ##########"