#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
kak_dir=$XDG_CONFIG_HOME/kak
[ -d $kak_dir ] || mkdir -p $kak_dir

ln -s $script_dir/kakrc $kak_dir/.
ln -s $script_dir/autoload $kak_dir/.
ln -s $script_dir/plugin $kak_dir/.

systemd_dir=$XDG_CONFIG_HOME/systemd/user
[ -d $systemd_dir ] || mkdir -p $systemd_dir
ln -s $script_dir/kakoune.service $systemd_dir/.

[ -d $HOME/bin ] || mkdir $HOME/bin
ln -s $script_dir/bin/kak-git $HOME/bin/.

plugin_dir=$HOME/workspace/kakoune-plugin
[ -d $kak_dir/develop ] || mkdir $kak_dir/develop

plugin() {
	ln -s $plugin_dir/$1/$1.kak $kak_dir/develop/.
}
plugin each-line-selection
plugin ibus
