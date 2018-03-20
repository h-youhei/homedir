#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
rg_dir=$XDG_CONFIG_HOME/ripgrep
[ -d $rg_dir ] || mkdir -p $rg_dir
ln -s $script_dir/ripgreprc $rg_dir/
