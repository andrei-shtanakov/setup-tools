#!/bin/bash
set -euo pipefail

echo "Installing Linux utilities..."

# --- helpers ----------------------------------------------------
append_once() {
  local line="$1" file="$2"
  grep -Fqx "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

# --- base deps --------------------------------------------------
sudo apt update -y
sudo apt install -y software-properties-common ca-certificates curl gnupg

# --- flatpak ----------------------------------------------------
sudo apt install -y flatpak
if ! flatpak remotes --columns=name | grep -Fxq flathub; then
  sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# XDG_DATA_DIRS, for .desktop from Flatpak is visible without reloading
append_once 'export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"' "$HOME/.profile"

# --- apt packages ----------------------------------------------
sudo apt install -y ncdu bat vim neovim
sudo add-apt-repository -y ppa:daniel-milde/gdu
sudo apt update -y
sudo apt install -y gdu
sudo apt install -y ffmpeg p7zip-full jq poppler-utils fd-find ripgrep fzf imagemagick

if command -v fdfind >/dev/null && ! command -v fd >/dev/null; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi
if command -v batcat >/dev/null && ! command -v bat >/dev/null; then
  sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat
fi

# --- zoxide -----------------------------------------------------
curl -sS https://webinstall.dev/zoxide | bash

append_once 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"
append_once 'eval "$(zoxide init bash)"' "$HOME/.bashrc"
append_once '[ -f "$HOME/.config/envman/PATH.env" ] && source "$HOME/.config/envman/PATH.env"' "$HOME/.bashrc"
if [ -f "$HOME/.config/envman/PATH.env" ]; then
  source "$HOME/.config/envman/PATH.env" || true
fi

# --- Flatpak apps ----------------------------------------------
flatpak install -y flathub io.github.sxyazi.yazi
flatpak install -y flathub org.kde.kate
flatpak install -y flathub org.kde.kwrite

echo "Linux utilities installed."

echo
echo ">> To apply shell changes now, run:"
echo "   source ~/.profile && source ~/.bashrc"

