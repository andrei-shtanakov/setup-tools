#!/bin/bash
set -e

echo "Installing Linux utilities..."

# Install flatpak
sudo apt install -y flatpak

# Install apt packages
sudo apt install -y ncdu bat vim neovim

# Add gdu repository and install
sudo add-apt-repository -y ppa:daniel-milde/gdu
sudo apt update -y
sudo apt install -y gdu

# Install additional tools via apt
sudo apt install -y ffmpeg p7zip-full jq poppler-utils fd-find ripgrep fzf imagemagick

# Install zoxide
curl -sS https://webinstall.dev/zoxide | bash

# Install flatpak applications
flatpak install -y flathub io.github.sxyazi.yazi
flatpak install -y flathub org.kde.kate
flatpak install -y flathub org.kde.kwrite

echo "Linux utilities installed."