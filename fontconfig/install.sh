#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

dest_dir=$XDG_CONFIG_HOME/fontconfig
[ -d $dest_dir ] || mkdir -p $dest_dir
ln -s $script_dir/fonts.conf $XDG_CONFIG_HOME/fontconfig/.
