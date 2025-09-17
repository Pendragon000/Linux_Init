#!/bin/bash
current_dir=$(pwd)
mkdir ~/Documents
mkdir ~/Documents/CEGEP
mkdir ~/Documents/projets

if [ -f /etc/os-release ]; then
  . /etc/os-release
  distro=$ID
else
  exit 1
fi

if [[ "$distro" == "arch" ]]; then
  echo "Detected Arch Linux"
  sudo pacman -Sy git neovim gcc gdb python python-pip rsync wireshark wireshark-cli
elif [[ "$distro" == "fedora" ]]; then
  echo "Detected Fedora"
  sudo dnf install -y git neovim gcc gdb python3 python3-pip rsync wireshark-qt wireshark-cli
else
  echo "Unsupported distribution: $distro"
  exit 1
fi

git --version
nvim --version
gcc --version
gdb --version
python3 --version
pip3 --version
rsync --version
wireshark --version

git config --global user.name "Isaak Fortin"
git config --global user.email "isaakfortnite56@gmail.com"
git config --global user.username "Pendragon000"
git config --global core.editor "nvim"

rsync -r $current_dir/.config ~/.config
rsync -r $current_dir/bin ~/

# Download Sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/sqlmap

cat ./.bashrc >~/.bashrc
cat ./.function_bashrc >~/.function_bashrc
cat ./.alias_bashrc >~/.alias_bashrc
