#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s $script_dir/tmux.conf $HOME/.tmux.conf

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config

ln -s $script_dir/key.zsh $XDG_CONFIG_HOME/zsh/terminal/tmux.zsh
