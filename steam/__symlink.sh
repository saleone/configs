#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
csgo="$DIR/games/csgo"
csgo_autoexec="$csgo/autoexec.cfg"
csgo_dm="$csgo/dm.cfg"
csgo_surf="$csgo/surf.cfg"
local_cfg_dir=~/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/csgo/cfg/
ln -sv $csgo_autoexec "$local_cfg_dir"
ln -sv $csgo_dm "$local_cfg_dir"
ln -sv $csgo_surf "$local_cfg_dir"
