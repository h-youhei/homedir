#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
systemd_dir=$XDG_CONFIG_HOME/systemd
[ -d $systemd_dir/user ] || mkdir -p $systemd_dir/user
