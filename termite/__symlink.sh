#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config="$DIR/config"
ln -s $config ~/.config/termite/
