#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xresources="$DIR/Xresources"
ln -s $xresources ~/.Xresources
