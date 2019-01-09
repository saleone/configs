# Use home as the main work directory
cd $HOME

# Update the system
dnf update -y

# Add RPM Fusion repository
su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y'
dnf copr enable nforro/i3-gaps -y
dnf copr enable jstanek/ports -y

dnf install \
    @base-x \
    git \
    @development-tools \
    i3-gaps \
    i3lock \
    ranger \
    NetworkManager-wifi \
    firefox \
    pulseaudio \
    pulseaudio-utils \
    pulseaudio-module-bluetooth \
    vlc \
    podman \
    tmux \
    vim-enhanced \
    vim-X11 \
    ncpamixer \
    rsync \
    podman \
    vagrant \
    VirtualBox \
    ImageMagick \
    feh \
    wget \
    curl \
    bash-completion \
    compton \
    lxterminal \
    brightnessctl \
    transmission-gtk \
    -y

dnf copr disable nforro/i3-gaps -y
dnf copr disable jstanek/ports -y

CONFIGS="$HOME/Dev/configs"
if [ ! -d $HOME/Dev ]; then
    mkdir $HOME/Dev
    git clone https://github.com/saleone/configs $CONFIGS
fi

echo "exec i3" >> ~/.xinitrc

cat >> ~/.bash_profile << BASH_PROFILE
# Start X on login
if [[ ! \$DISPLAY && \$XDG_VTNR -eq 1 ]]; then
    exec startx
fi
BASH_PROFILE

# TODO: Link the configs

curl -SL https://github.com/mozilla/Fira/archive/4.202.zip -o fira.zip
unzip fira.zip
if [ ! $HOME/.fonts ]; then
    mkdir $HOME/.fonts
fi
cp Fira-4.202/ttf/*.ttf $HOME/.fonts
rm -fr Fira-4.202/

curl -SL https://go.microsoft.com/fwlink/?LinkID=760867 -o vscode.rpm
dnf install vscode.rpm -y
rm -f vscode.rpm
