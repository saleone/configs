#!/bin/bash
HOME=/home/saleone
cd $HOME
echo ">>> Ubuntu bootstrap script <<<"
echo "! Please note that you may lose data when running this script !"
echo "Do you want to proceed? (yes/NO)"
read START_PROMPT
if [ ! $START_PROMPT ==  "yes" ]; then exit 0; fi

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

echo " > Set up Xfce 4"
bash $HOME/Dev/configs/xfce4/__symlink.sh

echo "Would you like to create SSH key? (yes/no)"
echo " > Create SSH key"
ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)"

echo " > Install Vim with Gtk3"
sudo apt install -y vim-gtk3

echo " > Install Curl"
sudo apt install -y curl

echo " > Set up Vim"
bash $HOME/Dev/configs/vim/__symlink.sh

echo " > Set up Bash"
bash $HOME/Dev/configs/bash/__symlink.sh
source $HOME/.bashrc

echo " > Set up i3"
bash $HOME/Dev/configs/i3/__symlink.sh

echo " > Set up Urxvt"
bash $HOME/Dev/configs/urxvt/__symlink.sh

echo " > Install Visual Studio Code"
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
sudo dpkg -i vscode.deb
rm -f vscode.deb
sudo apt install -f

echo " > Set up Visual Studio Code"
bash $HOME/Dev/configs/vscode/__symlink.sh

echo " > Install Gimp, Inkscape, Libre Office, Firefox"
sudo apt install gimp inkscape libreoffice firefox -y

echo " > Install Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo dpkg -i chrome.deb
rm -f chrome.deb
sudo apt install -f

echo " > Install Node.js"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install --global npm

echo " > Install bower "
sudo npm install -g bower

echo " > Install build essentials"
sudo apt install -y build-essential

echo " > Install Numix themes"
sudo add-apt-repository ppa:numix/ppa -y
sudo apt update
sudo apt install -y numix-gtk-theme numix-icon-theme-circle

echo " > Install Htop"
sudo apt install -y htop

echo " > Install f.lux"
sudo add-apt-repository ppa:nathan-renniewaldock/flux -y
sudo apt update
sudo apt install fluxgui -y

echo "Would you like to install Steam? (yes/No)"
echo " > Install Steam"
sudo apt install steam -y

echo " > Install Fira Fonts"
wget https://github.com/mozilla/Fira/archive/4.202.zip -O fira.zip
unzip fira.zip
if [ ! -d $HOME/.fonts ]; then
    mkdir -p $HOME/.fonts
fi
cp Fira-4.202/ttf/*.ttf $HOME/.fonts/
rm -f fira.zip
rm -fr Fira-4.202/

echo " > Install Docker"
curl -sSL https://get.docker.com/ | sh

echo " > Install PHP"
sudo apt install php php-curl php-mcrypt php-mbstring php-gettext -y

echo " > Install Composer"
wget https://getcomposer.org/installer -O composer-setup.php
php composer-setup.php --install-dir=$HOME/.my_bin --filename=composer
rm -f composer-setup.php

echo " > Install Vagrant"
wget https://releases.hashicorp.com/vagrant/1.9.0/vagrant_1.9.0_x86_64.deb -O vagrant.deb
sudo dpkg -i vagrant.deb
sudo apt install -f
rm -f vagrant.deb

echo " > Install virtualbox"
wget http://download.virtualbox.org/virtualbox/5.1.10/virtualbox-5.1_5.1.10-112026~Ubuntu~xenial_amd64.deb -O virtualbox.deb
sudo dpkg -i virtualbox.deb
sudo apt install -f
rm -f virtualbox.deb

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

echo " > Install Rust"
curl -sSf https://static.rust-lang.org/rustup.sh | sh

echo " > Download Rust sources (should be in RUST_SRC_PATH)"
git clone https://github.com/rust-lang/rust.git $RUST_REPO

echo " > Install plank"
sudo apt install plank -y

echo " > Install Paper cursor theme"
sudo add-apt-repository ppa:snwh/pulp -y
sudo apt update
sudo apt install paper-cursor-theme -y

echo " > Install Albert keyboard launcher"
sudo add-apt-repository ppa:nilarimogard/webupd8 -y
sudo apt-get update
sudo apt-get install albert -y

