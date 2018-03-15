#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

ln -s $script_dir/xtermrc $XDG_CONFIG_HOME/X11/Xresources.d/
