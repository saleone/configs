#!/bin/bash
HOME=/home/saleone
cd $HOME

echo " > Update system"
sudo apt update
sudo apt upgrade -y

echo " > Make Dev folder: $HOME/Dev"
mkdir -p $HOME/Dev

echo " > Remove folders that are not needed"
if [ -d $HOME/Documents ]; then
    rm -fr $HOME/Documents
fi
if [ -d $HOME/Public ]; then
    rm -fr $HOME/Public
fi
if [ -d $HOME/Templates ]; then
    rm -fr $HOME/Templates
fi

echo " > Installing Git"
sudo apt install -y git

echo " > Cloning configs from https://github.com/saleone/configs.git"
git clone https://github.com/saleone/configs.git $HOME/Dev/configs

echo " > Set up Git"
bash $HOME/Dev/configs/git/__symlink.sh

echo " > Set up Mercurial"
sudo apt install mercurial -y
bash $HOME/Dev/configs/mercurial/__symlink.sh

echo " > Install Curl"
sudo apt install -y curl

echo " > Set up Vim"
sudo apt install -y vim-gtk3
bash $HOME/Dev/configs/vim/__symlink.sh

echo " > Set up Bash"
bash $HOME/Dev/configs/bash/__symlink.sh
source $HOME/.bashrc

echo " > Install and setup Visual Studio Code"
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
sudo dpkg -i vscode.deb
rm -f vscode.deb
sudo apt install -f -y
bash $HOME/Dev/configs/vscode/__symlink.sh
bash $HOME/Dev/configs/vscode/install_extensions.sh

echo " > Install Gimp, Inkscape, Libre Office, Firefox"
sudo apt install gimp inkscape libreoffice firefox -y

echo " > Install Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo dpkg -i chrome.deb
rm -f chrome.deb
sudo apt install -f -y

echo " > Install Node.js"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install --global npm

echo " > Install gulp"
sudo npm install -g gulp-cli

echo " > Install build essentials"
sudo apt install -y build-essential

echo " > Install pip"
sudo apt install python-pip python3-pip -y
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip

echo " > Install pytest"
sudo pip install pytest
sudo pip3 install pytest

echo " > Install ipython"
sudo pip install ipython
sudo pip3 install ipython

echo " > Install editorconfg"
sudo apt install editorconfig -y

echo " > Install 7zip support"
sudo apt install p7zip-full

