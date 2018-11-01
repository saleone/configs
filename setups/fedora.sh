# Use home as the main work directory
cd $HOME

# Update the system
sudo dnf update -y

# Add RPM Fusion repository
su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y'

# Remove excess folders
if [ -d $HOME/Public ]; then
    rmdir $HOME/Public
fi

if [ -d $HOME/Templates ]; then
    rmdir $HOME/Templates
fi

# Make Dev folder and clone the configuration
CONFIGS="$HOME/Dev/configs"
if [ ! -d $HOME/Dev ]; then
    mkdir $HOME/Dev
    git clone https://github.com/saleone/configs $CONFIGS
fi

# Link the configs
bash $CONFIGS/git/__symlink.sh
bash $CONFIGS/vim/__symlink.sh
bash $CONFIGS/xfce4/__symlink.sh
bash $CONFIGS/bash/__symlink.sh
bash $CONFIGS/i3/__symlink.sh
bash $CONFIGS/vscode/__symlink.sh
bash $CONFIGS/compton/__symlink.sh

# Install vim
sudo dnf install vim-enhanced -y

# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "$(git config --global user.email)"

# Install Fira fonts
curl -SL https://github.com/mozilla/Fira/archive/4.202.zip -o fira.zip
unzip fira.zip
if [ ! $HOME/.fonts ]; then
    mkdir $HOME/.fonts
fi
cp Fira-4.202/ttf/*.ttf $HOME/.fonts
rm -fr Fira-4.202/

# Install Visual Studio Code
curl -SL https://go.microsoft.com/fwlink/?LinkID=760867 -o vscode.rpm
sudo dnf install vscode.rpm -y
rm -f vscode.rpm

# Install Virtualbox
sudo dnf install VirtualBox -y
sudo dnf install akmod-VirtualBox kernel-devel-4.8.6-300.fc25.x86_64
echo "NOTE: Enable kernel mods for VirtualBox"
#sudo akmods --kernels 4.8.6-300.fc25.x86_64 && systemctl restart systemd-modules-load.service

# Install Vagrant
sudo dnf install vagrant -y

# Install Gnome tweak tool
sudo dnf install gnome-tweak-tool

