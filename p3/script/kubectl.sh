
KUBECTL_DIR=$HOME/bin
# Create bin directory if it doesn't exist
mkdir -p $KUBECTL_DIR
# Download the latest release of kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Make the kubectl binary executable
chmod +x ./kubectl
# Move the binary to your bin directory
mv ./kubectl $KUBECTL_DIR/kubectl
# Add kubectl to PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
export PATH=$KUBECTL_DIR:$PATH