#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0])}")" && pwd)"

# i3
mkdir -p ~/.config/i3
ln -s "$DIR/i3/config" ~/.config/i3/config
ln -s "$DIR/i3/status" ~/.status
chmod +x ~/.status

# Git
ln -s "$DIR/git/gitconfig" ~/.gitconfig

# Bash
mv ~/.bashrc ~/.bashrc_wsl_old
ln -s "$DIR/bash/bashrc" ~/.bashrc
source ~/.bashrc

# Terminal
rm -fr ~/.config/xfce4
mkdir -p ~/.config/xfce4/terminal
ln -s "$DIR/xfce4/terminalrc" ~/.config/xfce4/terminal/terminalrc
