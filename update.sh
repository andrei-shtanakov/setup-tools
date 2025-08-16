#!/bin/bash
set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y