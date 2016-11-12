#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xresources="$DIR/Xresources"
xkrclipboard="$DIR/xkr-clipboard.pl"
if [ ! -d /usr/lib/urxvt/perl/ ]; then
    sudo mkdir -pv /usr/lib/urxvt/perl/
fi
if [ -f /usr/lib/urxvt/perl/xkr-clipboard ]; then
    sudo rm -f /usr/lib/urxvt/perl/xkr-clipboard
fi
sudo ln -s $xkrclipboard /usr/lib/urxvt/perl/xkr-clipboard

if [ -f ~/.Xresources ]; then
    rm -f ~/.Xresources
fi
ln -s $xresources ~/.Xresources
