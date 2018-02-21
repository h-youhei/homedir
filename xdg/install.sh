#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
[ -z $XDG_DATA_HOME ] && XDG_DATA_HOME=$HOME/.local/share
[ -z $XDG_CACHE_HOME ] && XDG_CACHE_HOME=$HOME/.cache

[ -d $XDG_CONFIG_HOME ] || mkdir -p $XDG_CONFIG_HOME
[ -d $XDG_DATA_HOME ] || mkdir -p $XDG_DATA_HOME
[ -d $XDG_CACHE_HOME ] || mkdir -p $XDG_CACHE_HOME

ln -s $script_dir/user-dirs.dirs $XDG_CONFIG_HOME/.
ln -s $script_dir/user-dirs.locale $XDG_CONFIG_HOME/.

command -v xdg-user-dirs-update && xdg-user-dirs-update
