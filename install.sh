#!/bin/bash

set -euo pipefail

cat ./.bashrc >$HOME/.bashrc
cat ./.function_bashrc >$HOME/.function_bashrc
cat ./.alias_bashrc >$HOME/.alias_bashrc
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

#Add Default user PATH
new_path='export PATH="$HOME/bin:$PATH"'
current_dir=$(pwd)

check_installed() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo -e "${GREEN}[OK]${NC} $cmd is installed → $($cmd --version | head -n1)"
  else
    echo -e "${RED}[MISSING]${NC} $cmd is not installed!"
  fi
}

mkdir -p "$HOME/Documents" "$HOME/Documents/CEGEP" "$HOME/Documents/projets"

if [ -f /etc/os-release ]; then
  . /etc/os-release
  distro=$ID
else
  exit 1
fi

# Installation des packet selon le distro
if [[ "$distro" == "arch" ]]; then
  echo "Detected Arch Linux"
  #Basic install
  sudo pacman -Sy git neovim rsync curl
  #Debuging Tools
  sudo pacman -Sy gcc gdb python python-pip
  #Network Tools
  sudo pacman -Sy wireshark-qt wireshark-cli
  #yay install & set up
  REPO_YAY_DIR="$HOME/yay"
  if [ ! -d "$REPO_YAY_DIR"]; then
    git clone --depth 1 https://aur.archlinux.org/yay.git "$REPO_YAY_DIR"
  else
    echo "Repository already cloned at $REPO_YAY_DIR"
  fi
  cd yay
  makepkg -si
  #yay Installs
  yay -S ghidra
elif [[ "$distro" == "fedora" ]]; then
  new_path='export PATH="$HOME/bin:/snap/bin:$PATH"'
  echo "Detected Fedora"
  #Basic install
  sudo dnf install -y git neovim rsync curl
  #Debuging Tools
  sudo dnf install -y gcc gdb python3 python3-pip snapd
  #Network Tools
  sudo dnf install -y wireshark wireshark-cli
  #Snap Installs
  sudo snap install ghidra
  sudo systemctl enable --now snapd.socket
  export PATH="$HOME/bin:/snap/bin:$PATH"
else
  echo "Unsupported distribution: $distro"
  exit 1
fi

# Verifie l'instalation
check_installed git
check_installed nvim
check_installed gcc
check_installed gdb
check_installed python3
check_installed pip3
check_installed rsync
check_installed wireshark
check_installed curl
check_installed ghidra
# Download gef pour gdb
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

git config --global user.name "Isaak Fortin"
git config --global user.email "isaakfortnite56@gmail.com"
git config --global user.username "Pendragon000"
git config --global core.editor "nvim"
# Syncronization de mes fichier
rsync -a "$current_dir/.config" "$HOME/.config"
rsync -a "$current_dir/bin" "$HOME/bin/"

# Download Sqlmap
REPO_SQLMAP_DIR="$HOME/sqlmap"
if [ ! -d "$REPO_SQLMAP_DIR" ]; then
  git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git "$REPO_SQLMAP_DIR"
else
  echo "Repository already cloned at $REPO_SQLMAP_DIR"
fi

echo $new_path >>$HOME/.bashrc
