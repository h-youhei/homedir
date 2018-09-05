#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
kak_dir=$XDG_CONFIG_HOME/kak
[ -d $kak_dir ] || mkdir -p $kak_dir

ln -s $script_dir/kakrc $kak_dir/
ln -s $script_dir/color.kak $kak_dir/
ln -s $script_dir/keymap.kak $kak_dir/
ln -s $script_dir/autoload $kak_dir/

[ -d $HOME/bin ] || mkdir $HOME/bin
bin() {
	ln -s $script_dir/bin/$1 $HOME/bin/
}
bin kak-git
bin kaklip

[ -d $kak_dir/plugin ] || mkdir $kak_dir/plugin
plugin_dir=$HOME/workspace/kakoune-plugin

plugin() {
	ln -s $script_dir/plugin/$1.kak $kak_dir/plugin/
}

plugin_local() {
	ln -s $plugin_dir/$1/$1.kak $kak_dir/plugin/
}

#plugin_remote() {
#}

plugin capslock
plugin multiple-insert
plugin copy-or-shrink
plugin_local each-line-selection
plugin_local surround
plugin_local close-tag
plugin_local ibus
