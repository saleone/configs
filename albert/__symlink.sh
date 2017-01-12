#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
albert="$DIR/albert.conf"
mkdir -p ~/.config/albert
ln -s $albert ~/.config/albert/albert.conf
