#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

alias_dir=$XDG_CONFIG_HOME/sh-common/alias.d
[ -d $alias_dir ] || mkdir -p $alias_dir

ln -sf $script_dir/alias.sh $alias_dir/package-manager.sh
