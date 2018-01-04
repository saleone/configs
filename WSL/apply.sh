#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0])}")" && pwd)"

# i3
rm -fr ~/.config/i3_wsl_old
rm -fr ~/.config/.stastus_old
mv ~/.config/i3 ~/.config/i3_wsl_old
mv ~/.status ~/.status_old
mkdir -p ~/.config/i3
ln -s "$DIR/i3/config" ~/.config/i3/config
ln -s "$DIR/i3/status" ~/.status
chmod +x ~/.status

# Git
rm -fr ~/.gitconfig_wsl_old
mv ~/.gitconfig ~/.gitconfig_wsl_old
ln -s "$DIR/git/gitconfig" ~/.gitconfig

# Bash
rm -fr ~/.bashrc_wsl_old
mv ~/.bashrc ~/.bashrc_wsl_old
ln -s "$DIR/bash/bashrc" ~/.bashrc
source ~/.bashrc

# XFCE4 & Terminal
bash xfce4/__symlink.sh

# Vim
bash vim/__symlink.sh
