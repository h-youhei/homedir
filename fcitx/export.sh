#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
fcitx_dir=$XDG_CONFIG_HOME/fcitx

rsync -a -v $fcitx_dir/config $fcitx_dir/conf $fcitx_dir/addon $script_dir/fcitx
