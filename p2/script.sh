
masterIP="192.168.56.110"
k3sTokenFile="/var/lib/rancher/k3s/server/node-token"
flags="--tls-san $masterIP --node-external-ip $masterIP"  #helps so k3s master listens on its real IP and accepts requests by putting its IP inside the cert.

echo "[INFO] Install k3s on master-node"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$flags" K3S_NODE_NAME="anassifS" K3S_KUBECONFIG_MODE="644" sh - #K3S_KUBECONFIG_MODE for perm so its access rancher folder
