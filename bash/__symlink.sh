#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bashrc="$DIR/bashrc"
ln -s $bashrc ~/.bashrc
. ~/.bashrc
