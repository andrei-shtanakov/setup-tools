#!/bin/bash
set -e

echo "Installing essential tools..."
sudo apt update && sudo apt install -y \
    git curl wget unzip htop xclip \
    docker.io docker-compose-plugin

echo "Essential tools installed."

echo "Adding user to Docker group..."
sudo usermod -aG docker "$(whoami)"

echo "You've been added to the Docker group."
echo "You may need to log out or run: newgrp docker"