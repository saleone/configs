#!/bin/bash

HOME=/home/saleone
DATA=$HOME/Data

cd $HOME

echo ">>> Ubuntu bootstrap script <<<"
echo "! Please note that you may lose data when running this script !"
echo "Do you want to proceed? (yes/NO)"
read START_PROMPT
if [ ! $START_PROMPT ==  "yes" ]; then exit 0; fi

echo " > Update system"
sudo apt update
sudo apt upgrade -y

echo " > Mount the data drive to: $HOME/Data"
mkdir -p $DATA
sudo mount /dev/sda2 $DATA

echo " > Make Dev folder: $DATA/Dev"
mkdir -p $DATA/Dev

echo " > Create links to common folders"
echo "  - $DATA/Dev -> $HOME/Dev"
if [ ! -L $HOME/Dev ]; then
	ln -s $DATA/Dev
fi

if [[ -d $HOME/Downloads && ! -L $HOME/Downloads ]]; then
	echo "    ! Removing $HOME/Downloads."
	rmdir $HOME/Downloads
fi
echo "  - $DATA/Downloads -> $HOME/Downloads"
if [ ! -L $HOME/Downloads ]; then
	ln -s $DATA/Downloads
fi

echo "  - $DATA/GDrive -> $HOME/GDrive"
if [ ! -L $HOME/GDrive ]; then
	ln -s $DATA/GDrive
fi

echo "  - $DATA/Multimedia/Pictures -> $HOME/Pictures"
if [ -d $HOME/Pictures ]; then
    rm -fr $HOME/Pictures
fi
ln -s $DATA/Multimedia/Pictures

echo "  - $DATA/Multimedia/Videos -> $HOME/Videos"
if [ -d $HOME/Videos ]; then
    rm -fr $HOME/Videos
fi
ln -s $DATA/Multimedia/Videos

echo "  - $DATA/Multimedia/Music -> $HOME/Music"
if [ -d $HOME/Music ]; then
    rm -fr $HOME/Music
fi
ln -s $DATA/Multimedia/Music

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
git clone https://github.com/saleone/configs.git $DATA/Dev/configs

echo " > Set up Git"
bash $DATA/Dev/configs/git/__symlink.sh

echo "Would you like to create SSH key? (yes/no)"
read SSH_PROMPT
if [ $SSH_PROMPT == "yes" ]; then
    echo " > Create SSH key"
    ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)"
fi

echo " > Install Vim with Gtk3"
sudo apt install -y vim-gtk3

echo " > Install Curl"
sudo apt install -y curl

echo " > Set up Vim"
bash $DATA/Dev/configs/vim/__symlink.sh

echo " > Set up Bash"
bash $DATA/Dev/configs/bash/__symlink.sh
source $HOME/.bashrc

echo " > Set up i3"
bash $DATA/Dev/configs/i3/__symlink.sh

echo " > Set up Urxvt"
bash $DATA/Dev/configs/urxvt/__symlink.sh

echo " > Install Visual Studio Code"
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
sudo dpkg -i vscode.deb
rm -f vscode.deb
sudo apt install -f

echo " > Set up Visual Studio Code"
bash $DATA/Dev/configs/vscode/__symlink.sh

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

echo " > Install build essentials"
sudo apt install -y build-essential

echo " > Install Numix themes"
sudo add-apt-repository ppa:numix/ppa -y
sudo apt update
sudo apt install -y numix-gtk-theme numix-icon-theme-circle

echo "Do you want to install Lektor (https://getlektor.com) ? (yes/NO)"
read LEKTOR_PROMPT
if [ $LEKTOR_PROMPT == "yes" ]; then
    sudo apt install -y python-dev libssl-dev libffi-dev imagemagick
    curl -sf https://www.getlektor.com/install.sh | sudo sh
fi

echo " > Install Htop"
sudo apt install -y htop

echo " > Install f.lux"
sudo add-apt-repository ppa:nathan-renniewaldock/flux -y
sudo apt update
sudo apt install fluxgui -y

echo "Would you like to install Steam? (yes/No)"
read STEAM_PROMPT
if [ ! $STEAM_PROMPT ==  "yes" ]; then
    echo " > Install Steam"
    sudo apt install steam -y
fi

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
sudo apt install php, php-curl, php-mcrypt, php-mbstring, php-gettext

echo " > Install Composer"
wget https://getcomposer.org/installer -O composer-setup.php
php composer-setup.php --install-dir=$HOME/.my_bin --filename=composer
rm -f composer-setup.php

echo " > Install Homestead for Laravel"
composer global require "laravel/homestead=~2.0"

echo " > Install Rofi"
sudo apt install rofi

echo " > Install Compton"
sudo apt install compton

echo " > Link Compton configuration"
bash $DATA/Dev/configs/compton/__symlink.sh


