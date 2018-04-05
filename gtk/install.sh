#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
gtk_dir=$XDG_CONFIG_HOME/gtk-3.0
[ -d $gtk_dir ] || mkdir -p gtk_dir
ln -s $script_dir/settings.ini $gtk_dir/
