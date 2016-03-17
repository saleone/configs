#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
gitconfig="$DIR/gitconfig"
ln -s $gitconfig ~/.gitconfig
