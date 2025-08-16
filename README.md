# Workstation setup   
## update   
preparation:  
```
#!/bin/bash
set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
```
   
## tools   
Essential tools only:   
```
#!/bin/bash
set -e

echo "Installing essential tools..."
sudo apt update && sudo apt install -y \
    git curl wget unzip htop xclip \
    docker.io docker-compose-plugin

echo "Essential tools installed."

```
Add user to Docker group:
```
#!/bin/bash
set -e

echo "Adding user to Docker group..."
sudo usermod -aG docker "$(whoami)"

echo "You’ve been added to the Docker group."
echo " You may need to log out or run: newgrp docker"
```
   
## dev-tools   
Tools for Python
```
#!/bin/bash
set -e

echo "Installing dev tools..."
sudo apt install -y \ 
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev \
    llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev \
    python3-openssl


curl https://pyenv.run | bash

echo "pyenv installed."

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

curl -LsSf https://astral.sh/uv/install.sh | sh
echo "uv installed."
echo "Dev tools installed."

```
## linux-tools   
linux utilities   
```
#!/bin/bash
set -e

echo "Installation Linux utilities..."
sudo apt install flatpak
sudo apt install ncdu
sudo apt install bat
sudo add-apt-repository ppa:daniel-milde/gdu
sudo apt update -y
sudo apt install gdu
sudo port install yazi \
    ffmpeg 7zip jq poppler \
    fd ripgrep fzf zoxide ImageMagick
flatpak install flathub io.github.sxyazi.yazi
flatpak install flathub org.kde.kate
flatpak install flathub org.kde.kwrite
sudo apt install vim
sudo apt install neovim
echo "Linux utilities installed."

```
   
   
   
## Additional setup 
   
In this case only Oh My Zsh + Powerlevel10k Prompt   
   
```
#!/bin/bash
set -e

echo "Installing Zsh..."
sudo apt install -y zsh fonts-powerline

echo "Installing Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Setting theme in .zshrc..."
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

echo "Oh My Zsh and Powerlevel10k installed."
echo "  Run 'chsh -s $(which zsh)' to make Zsh your default shell."
```
Git configuration
```
#!/bin/bash
set -e

echo "Configuring Git..."

read -p "Enter your Git name: " name
read -p "Enter your Git email: " email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global init.defaultBranch master
git config --global pull.rebase true
git config --global color.ui auto

echo "Git configured."
```
   
## Makefile available targets:
main          - Run main setup (update + tools + dev-tools)
full-setup    - Run full workstation setup (all scripts)
update        - Update system packages
tools         - Install essential tools
dev-tools     - Install development tools
linux-tools   - Install Linux utilities
additional-setup - Install Zsh, Oh My Zsh, and configure Git
make-executable - Make all scripts executable
help          - Show this help message
