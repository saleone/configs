#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bashrc="$DIR/bashrc"

if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi

ln -s $bashrc ~/.bashrc
. ~/.bashrc
