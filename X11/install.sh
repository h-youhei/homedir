#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
x11_dir=$XDG_CONFIG_HOME/X11
[ -d $x11_dir ] || mkdir -p $x11_dir
[ -d $x11_dir/Xresources.d ] || mkdir $x11_dir/Xresources.d
[ -d $x11_dir/xinitrc.d ] || mkdir $x11_dir/xinitrc.d

ln -s $script_dir/color $XDG_CONFIG_HOME/X11/Xresources.d/.
ln -s $script_dir/xresources $XDG_CONFIG_HOME/X11/Xresources.d/.
ln -s $script_dir/xinitrc $HOME/.xinitrc
ln -s $script_dir/xserverrc $HOME/.xserverrc
