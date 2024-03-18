#!/bin/bash
# masterIP="192.168.56.110"
# flags="--tls-san $masterIP --node-external-ip $masterIP"

k3s_Token=$(cat /vagrant/token.env)
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=${k3s_Token} sh -
# curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token ${k3s-Token} --node-ip =https://192.168.56.111" sh -
#curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$k3s_Token sh - --node-ip https://192.168.56.110

# curl -sfL https://get.k3s.io | sh -s - 
