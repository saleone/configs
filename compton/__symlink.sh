#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
compton_conf="$DIR/compton.conf"

if [ -f ~/.config/compton.conf ]; then
    rm ~/.config/compton.conf
fi

ln -s $compton_conf ~/.config/compton.conf
