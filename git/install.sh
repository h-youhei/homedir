#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
[ -d $XDG_CONFIG_HOME/git ] mkdir -p $XDG_CONFIG_HOME/git
[ -f $XDG_CONFIG_HOME/git/config ] cp -a $script_dir/config $XDG_CONFIG_HOME/git/.

cd $script_dir
git remote set-url origin git@github.com:h-youhei/homedir.git
