#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
redshift="$DIR/redshift.conf"
ln -s $redshift ~/.config/redshift.conf
