#!/bin/bash

#brew
if which brew; then
    echo "Homebrew is already installed"
else
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#docker
if which docker; then
	echo "Docker is already installed."
else
	bash ./scripts/docker.sh
	echo "docker has been installed successfully."
fi

#kubectl
if which kubectl; then
	echo "kubectl is already installed."
else
	echo "kubectl is not installed. Installing kubectl..."
	bash ./scripts/kubectl.sh
	echo "kubectl has been installed successfully."
fi

#k3d
if which k3d;then
    tput setaf 2; echo "K3d is already installed"
else
    tput setaf 2; echo "K3d is instalation..."
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash > /dev/null
fi

sleep 1

if ! docker network inspect argo-gitlab >/dev/null 2>&1; then
    docker network create argo-gitlab
    echo "Docker network 'argo-gitlab' created."
else
    echo "Docker network 'argo-gitlab' already exists."
fi

tput setaf 2; echo "Checking for existing cluster"

# Check if the K3d cluster exists, create it if it doesn't
if ! k3d cluster list | grep -q "p3"; then
    echo "Creating cluster with K3d"
    k3d cluster create p3 --network argo-gitlab -p "8081:30001@agent:0" --agents 1 > /dev/null
    echo "K3d cluster 'p3' created."
else
    echo "K3d cluster 'p3' already exists."
fi

sleep 1

tput setaf 2; echo "Creation namespaces"
kubectl create ns argocd > /dev/null
kubectl create ns gitlab > /dev/null
tput setaf 2; echo "there is two namespaces argocd and gitlab"

sleep 1

tput setaf 2; echo "Installation of Argo Cd inside arcocd namespace"
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd > /dev/null

echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=Available deployment/argocd-server -n argocd --timeout=5m
