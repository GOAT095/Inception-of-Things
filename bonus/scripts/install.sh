#!/bin/bash

#Update the package list
echo "Updating package list..."
sudo apt-get update

#install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip 192.168.56.110" sh -


#Add the GitLab package repository
echo "Adding GitLab package repository..."
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

#Install GitLab Community Edition
#The EXTERNAL_URL line in the Vagrantfile is part of the GitLab installation process. 
#This environment variable specifies the URL at which GitLab will be accessible 
#once installed. It is crucial for GitLab's configuration because it tells GitLab how it should generate URLs for accessing the web interface and API.
sudo EXTERNAL_URL="http://localhost" apt-get install -y gitlab-ce

#Configure GitLab (assuming default URL, you may need to adjust external_url)
echo "Configuring GitLab..."
sudo gitlab-ctl reconfigure


tput setaf 2 ; echo "password: "

#extracting the password of gitlab initial root password 
sudo cat /etc/gitlab/initial_root_password | grep "Password:"

#Print the status of GitLab services
echo "Checking GitLab status..."
sudo gitlab-ctl status

sleep 10

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