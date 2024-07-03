#!/bin/bash

#curl
if ! [ -x "$(command -v curl)" ]; then
	if [ -x "$(command -v brew)" ]; then
		echo "Using Homebrew to install curl..."
		brew install curl
	else
		echo "Homebrew not found. Using apt-get for installation..."

		# Check if the package manager is apt-get (for Debian/Ubuntu-based systems)
		if [ -x "$(command -v apt-get)" ]; then
		echo "Installing curl with apt-get..."

		# Install curl using apt-get without sudo
		apt-get update
		apt-get install -y curl
		else
		echo "Unsupported package manager. Please install curl manually."
		exit 1
		fi
	fi
else
	echo "curl is already installed."
fi

#docker
if ! [ -x "$(command -v docker)" ]; then
	echo "Docker is not installed. Installing Docker..."
	bash docker.sh
	echo "Docker has been installed successfully."
else
	echo "Docker is already installed."
fi

#kubectl
if ! [ -x "$(command -v kubectl)" ]; then
	echo "kubectl is not installed. Installing kubectl..."
	bash kubectl.sh
	echo "kubectl has been installed successfully."
else
	echo "kubectl is already installed."
fi

#k3d
if which k3d;then
    tput setaf 2; echo "K3d is already installed"
else
    tput setaf 2; echo "K3d is instalation..."
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash > /dev/null
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

echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=Available deployment/argocd-server -n argocd --timeout=5m
