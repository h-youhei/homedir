#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
kak_dir=$XDG_CONFIG_HOME/kak
[ -d $kak_dir ] || mkdir -p $kak_dir

ln -s $script_dir/kakrc $kak_dir/.
ln -s $script_dir/autoload $kak_dir/.
ln -s $script_dir/plugin $kak_dir/.

plugin_dir=$HOME/workspace/kakoune-plugin
[ -d $kak_dir/develop ] || mkdir $kak_dir/develop

ln -s $plugin_dir/each-line-selection/each-line-selection.kak $kak_dir/develop/.
