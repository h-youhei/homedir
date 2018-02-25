#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

ln -s $script_dir/urxvtrc $XDG_CONFIG_HOME/X11/Xresources.d/.
ln -s $script_dir/xinit.sh $XDG_CONFIG_HOME/X11/xinitrc.d/50-urxvtd.sh 
ln -s $script_dir/key.zsh $XDG_CONFIG_HOME/zsh/terminal/urxvt.zsh
