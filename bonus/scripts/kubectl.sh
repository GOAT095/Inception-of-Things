sudo chown $(whoami):$(whoami) ~/.kube/config
chmod 600 ~/.kube/config

sudo usermod -aG docker $USER

if which brew; then
    echo "Homebrew is already installed"
else
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/ubuntu/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
		
brew install kubectl