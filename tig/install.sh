#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
tig_dir=$XDG_CONFIG_HOME/tig
[ -d $tig_dir ] || mkdir -p $tig_dir
ln -s $script_dir/config $tig_dir/

#tig saves history here if it exists.
[ -z $XDG_DATA_HOME ] && XDG_DATA_HOME=$HOME/.local/share
[ -d $XDG_DATA_HOME/tig ] || mkdir -p $XDG_DATA_HOME/tig
