#old master
#curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --tls-san anassifS


masterIP="192.168.56.110"
# k3sTokenFile="/var/lib/rancher/k3s/server/node-token"
flags="--tls-san $masterIP --node-external-ip $masterIP --node-ip $masterIP"  #helps so k3s master listens on its real IP and accepts requests by putting its IP inside the cert.

echo "[INFO] Install k3s on master-node"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$flags" K3S_NODE_NAME="anassifS" K3S_KUBECONFIG_MODE="644" sh - #K3S_KUBECONFIG_MODE for perm so its access rancher folder


#sleep so k3s starts properly and we find the files
sleep 30

#cp the vagrant token to vagrant folder
sudo rm -rf /vagrant/token.env
sudo rm -rf /vagrant/k3s.yaml

sudo cat /var/lib/rancher/k3s/server/token >> /vagrant/token.env
sudo sed -i 's/127.0.0.1/192.168.56.110/g' /etc/rancher/k3s/k3s.yaml
sudo cat /etc/rancher/k3s/k3s.yaml >> /vagrant/k3s.yaml

#i need to take a look at this next to sole kubectl problem on slave
#sudo vi /var/lib/rancher/k3s/config.yaml