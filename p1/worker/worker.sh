#!/bin/bash
# masterIP="192.168.56.110"
# flags="--tls-san $masterIP --node-external-ip $masterIP"

k3s_Token=$(cat /vagrant/token.env)
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$k3s_Token sh -

# curl -sfL https://get.k3s.io | sh -s - 
#curl -sfL https://get.k3s.io | K3S_URL=https://<manager ip address>:6443 K3S_TOKEN=K1073b3f02527159c80edf837727ae35cde5169707a7be0ecc91ca5a852e1e2c76f::server:c86cf36c0577ece1ef6d2cf072ece1c4 sh -