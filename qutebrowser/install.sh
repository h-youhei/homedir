#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME = $HOME/.config
[ -z $XDG_DATA_HOME ] && XDG_DATA_HOME = $HOME/.local/share

config_dir=$XDG_CONFIG_HOME/qutebrowser
data_dir=$XDG_DATA_HOME/qutebrowser
[ -d $config_dir ] || mkdir -p $config_dir
[ -d $data_dir ] || mkdir -p $data_dir

ln -s $script_dir/scripts/ibus-off.sh $data_dir/userscripts/
ln -s $script_dir/config.py $config_dir/
ln -s $script_dir/userstyle.css $config_dir/
