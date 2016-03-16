#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIMRC="$DIR/vimrc"
ln -s $VIMRC ~/.vimrc
