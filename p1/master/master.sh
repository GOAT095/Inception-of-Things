#registering a server without flannel and with a token
#644 to resolve rancher error https://thriveread.com/unable-to-read-etc-rancher-k3s-k3s-yaml-error/
#kubeconfig_mode for rancher error k3s & controller mode -  url is to define the agent
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=123456 sh -s