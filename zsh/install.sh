#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s $script_dir/zshenv $HOME/.zshenv

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
zsh_dir=$XDG_CONFIG_HOME/zsh
[ -d $zsh_dir ] || mkdir -p $zsh_dir

ln -s $script_dir/zshrc $zsh_dir/.zshrc
ln -s $script_dir/zprofile $zsh_dir/.zprofile
ln -s $script_dir/conf.d $zsh_dir/.
ln -s $script_dir/completions $zsh_dir/.

[ -d $zsh_dir/terminal ] || mkdir $zsh_dir/terminal
ln -s $script_dir/terminal/linux.zsh $zsh_dir/terminal/.
ln -s $script_dir/terminal/xterm.zsh $zsh_dir/terminal/.
