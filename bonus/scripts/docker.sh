set -e

# Install packages to allow apt to use a repository over HTTPS
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# Install the latest version of Docker CE
apt-get install -y docker-ce docker-ce-cli containerd.io

# Check if Docker daemon is running and start it if not
sudo systemctl start docker

# Add the current user to the docker group if not already added
if ! groups $USER | grep -q "\bdocker\b"; then
  echo "Adding the current user to the docker group..."
  sudo usermod -aG docker $USER
  sudo systemctl restart docker
  newgrp docker
  echo "User added to the docker group."
  echo "Please log out and log back in to apply the changes."
else
  echo "The current user is already in the docker group."
fi

# Set Kubernetes config file path
export KUBECONFIG=$HOME/.kube/config

# Disable k3d init checks
export K3D_NO_INIT_CHECK=true