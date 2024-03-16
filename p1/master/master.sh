#registering a server without flannel and with a token
#644 to resolve rancher error https://thriveread.com/unable-to-read-etc-rancher-k3s-k3s-yaml-error/
#kubeconfig_mode for rancher error k3s & controller mode -  url is to define the agent
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --prefer-bundled-bin --flannel-backend none --token 12345