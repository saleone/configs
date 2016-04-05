#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
i3config="$DIR/config"
status_script="$DIR/status"
ln -s $i3config ~/.config/i3/config
ln -s $status_script ~/.status
