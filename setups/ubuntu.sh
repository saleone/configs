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

echo " > Set up Mercurial"
sudo apt install mercurial -y
bash $HOME/Dev/configs/mercurial/__symlink.sh

echo "Creating SSH key"
echo " > Create SSH key"
ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)"

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
sudo apt install -f
bash $HOME/Dev/configs/vscode/__symlink.sh
bash $HOME/Dev/configs/vscode/install_extensions.sh

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

echo " > Install bower"
sudo npm install -g bower

echo " > Install gulp"
sudo npm install -g gulp-cli

echo " > Install build essentials"
sudo apt install -y build-essential

echo " > Install Htop"
sudo apt install -y htop

echo " > Install redshift"
sudo apt install redshift -y
bash $HOME/Dev/configs/redshift/__symlink.sh

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

echo " > Install plank"
sudo apt install plank -y

echo " > Install Paper cursor and icon themes"
sudo add-apt-repository ppa:snwh/pulp -y
sudo apt update
sudo apt install paper-cursor-theme -y
sudo apt install paper-icon-theme -y

