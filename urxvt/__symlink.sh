#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xresources="$DIR/Xresources"
xkrclipboard="$DIR/xkr-clipboard.pl"
if [ ! -d /usr/lib/urxvt/perl/ ]; then 
    sudo mkdir -pv /usr/lib/urxvt/perl/
fi
sudo ln -s $xkrclipboard /usr/lib/urxvt/perl/xkr-clipboard
ln -s $xresources ~/.Xresources
