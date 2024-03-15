#!/bin/bash

# Install k3s agent node in agent mode
#curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.111:6443 K3S_TOKEN=123456 sh -
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token mypassword" sh -s -
