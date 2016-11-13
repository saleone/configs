#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
xfce4_config="$DIR/xfce4"
rm -fr ~/.config/xfce4
ln -s $xfce4_config ~/.config/xfce4
