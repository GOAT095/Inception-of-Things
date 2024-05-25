#!/bin/bash

#Update the package list
echo "Updating package list..."
sudo apt-get update

# #Install necessary dependencies
# echo "Installing dependencies..."
# sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

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