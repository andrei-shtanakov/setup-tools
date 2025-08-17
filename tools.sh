#!/bin/bash
set -e

echo "Cleaning of previous Docker..."
sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc || true


echo "Installing essential tools..."
sudo apt update && sudo apt install -y \
    git curl wget unzip htop xclip \
    ca-certificates gnupg lsb-release

echo "Essential tools installed."

echo "Add offisial GPG key for Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Add offisial Docker repo..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Обновление списков пакетов..."
sudo apt-get update

echo "Installationi Docker and Docker Compose..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "Adding user to Docker group..."
sudo usermod -aG docker "$(whoami)"

echo "You've been added to the Docker group."
echo "You may need to log out or run: newgrp docker"
