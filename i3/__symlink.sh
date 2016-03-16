#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
i3config="$DIR/config"
ln -s $i3config ~/.config/i3/config
