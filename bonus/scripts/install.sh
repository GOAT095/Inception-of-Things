#!/bin/bash

#Exit immediately if a command exits with a non-zero status
set -e

#Update the package list
echo "Updating package list..."
sudo apt-get update

#Install necessary dependencies
echo "Installing dependencies..."
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl

#Add the GitLab package repository
echo "Adding GitLab package repository..."
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

#Install GitLab Community Edition
echo "Installing GitLab CE..."
sudo apt-get install -y gitlab-ce

#Configure GitLab (assuming default URL, you may need to adjust external_url)
echo "Configuring GitLab..."
sudo gitlab-ctl reconfigure

#Print the status of GitLab services
echo "Checking GitLab status..."
sudo gitlab-ctl status