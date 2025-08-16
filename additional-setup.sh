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
echo "Run 'chsh -s $(which zsh)' to make Zsh your default shell."

echo ""
echo "Configuring Git..."

read -p "Enter your Git name: " name
read -p "Enter your Git email: " email

git config --global user.name "$name"
git config --global user.email "$email"
git config --global init.defaultBranch master
git config --global pull.rebase true
git config --global color.ui auto

echo "Git configured."