#old master
#curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --tls-san anassifS


masterIP="192.168.56.110"
k3sTokenFile="/var/lib/rancher/k3s/server/node-token"
flags="--tls-san $masterIP --node-external-ip $masterIP"

echo "[INFO] Install k3s on master-node"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$flags" K3S_NODE_NAME="anassifS" K3S_KUBECONFIG_MODE="644" sh -

# echo "[INFO] Expose K3S_TOKEN from master-node for worker-node setup"
# cp "$k3sTokenFile" /vagrant/resources/.generated/k3s.token

#cp the vagrant token to vagrant folder
sudo cat /var/lib/rancher/k3s/server/token >> /vagrant/token.env