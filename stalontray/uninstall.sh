#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

unlink $HOME/.stalonetrayrc
unlink $XDG_CONFIG_HOME/X11/xinitrc.d/10-tray.sh
