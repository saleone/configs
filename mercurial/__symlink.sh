#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
hgrc="$DIR/hgrc"
ln -s $hgrc ~/.hgrc
