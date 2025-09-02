#!/bin/bash

mkdir ~/Documents
mkdir ~/Documents/CEGEP
mkdir ~/Documents/projets

sudo pacman -Sy git neovim gcc gdb python python-pip rsync

git --version
nvim --version
gcc --version
gdb --version
python3 --version
pip3 --version

git config --global user.name "Isaak Fortin"
git config --global user.email "isaakfortnite56@gmail.com"
git config --global user.username "Pendragon000"
git config --global core.editor "nvim"

rsync -r ~/Linux_Init/.config ~/.config
rsync -r ~/Linux_Init/bin ~/
