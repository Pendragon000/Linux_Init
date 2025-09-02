#!/bin/bash

mkdir ~/bin
mkdir ~/Documents
mkdir ~/Documents/CEGEP
mkdir ~/Documents/projets

sudo pacman -Sy git neovim gcc gdb python python-pip

git --version
nvim --version
gcc --version
gdb --version
python3 --version
pip3 --version
