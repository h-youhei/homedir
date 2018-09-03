#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
awesome_dir=$XDG_CONFIG_HOME/awesome
[ -d $awesome_dir ] || mkdir -p $awesome_dir

for f in $script_dir/?*.lua ; do
	ln -s $f $awesome_dir/.
done
unset f

ln -sf $script_dir/xinit.sh $XDG_CONFIG_HOME/X11/xinitrc.d/99-window-manager.sh
