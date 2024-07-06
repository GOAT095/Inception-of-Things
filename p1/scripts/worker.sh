#!/bin/bash
slaveIP="192.168.56.111"
# flags="--tls-san $masterIP --node-external-ip $masterIP"
sudo mkdir -p /etc/rancher/k3s/
k3s_Token=$(cat /vagrant/token.env)
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip $slaveIP" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=${k3s_Token} sh -

# curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token ${k3s-Token} --node-ip =https://192.168.56.111" sh -
#curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$k3s_Token sh - --node-ip https://192.168.56.110


sleep 30

#bayn hadchi
sudo cp /vagrant/k3s.yaml /etc/rancher/k3s/k3s.yaml
sudo rm -rf /vagrant/k3s.yaml
sudo rm -rf /vagrant/token.env
sudo apt-get install -y net-tools