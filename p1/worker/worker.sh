#!/bin/bash
masterIP="192.168.56.110"
flags="--tls-san $masterIP --node-external-ip $masterIP"
# Install k3s agent node in agent mode
#curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.111:6443 K3S_TOKEN=123456 sh -
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$flags" K3S_KUBECONFIG_MODE="644" sh -
#curl -sfL https://get.k3s.io | K3S_URL=https://<manager ip address>:6443 K3S_TOKEN=K1073b3f02527159c80edf837727ae35cde5169707a7be0ecc91ca5a852e1e2c76f::server:c86cf36c0577ece1ef6d2cf072ece1c4 sh -