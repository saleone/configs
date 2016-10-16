#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

settings="$DIR/settings.json"

if [ ! -d ~/.config/Code/User ]; then
    mkdir --parents ~/.config/Code/User
fi

if [ -f ~/.config/Code/User/settings.json ]; then
    rm ~/.config/Code/User/settings.json
fi

ln -s $settings ~/.config/Code/User/settings.json

keybindings="$DIR/keybindings.json"

if [ -f ~/.config/Code/User/keybindings.json ]; then
    rm ~/.config/Code/User/keybindings.json
fi

ln -s $keybindings ~/.config/Code/User/keybindings.json
