#!/bin/bash
set -e


echo "Creating standard DevOps folder structure..."
mkdir -p ~/devops/{projects,scripts,logs,tools}
echo "Folders created at ~/devops/"

echo "Installing Terraform..."
if ! command -v terraform &> /dev/null; then
    wget -q https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip -O terraform.zip
    unzip terraform.zip
    sudo mv terraform /usr/local/bin/
    rm terraform.zip
    echo "Terraform installed."
else
    echo "Terraform already installed. Skipping."
fi

echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
echo "AWS CLI installed."

echo "Installing ansible"
sudo apt update
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
echo "Ansible installed."

echo "Installing LocalStack CLI..."
curl --output localstack-cli-4.7.0-linux-arm64-onefile.tar.gz \
    --location https://github.com/localstack/localstack-cli/releases/download/v4.7.0/localstack-cli-4.7.0-linux-arm64-onefile.tar.gz
sudo tar xvzf localstack-cli-4.7.0-linux-*-onefile.tar.gz -C /usr/local/bin
echo "LocalStack installed."

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
