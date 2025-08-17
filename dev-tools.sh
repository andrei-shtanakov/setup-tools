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
