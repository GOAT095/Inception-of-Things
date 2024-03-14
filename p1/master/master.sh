#registering a server without flannel and with a token
if curl -sfL https://get.k3s.io | sh -s - --flannel-backend none --token 12345;then
    echo -e "instalattion was successful"
else
    echo -e "error k3s install"
