#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
git_dir=$XDG_CONFIG_HOME/git
[ -d $git_dir ] || mkdir -p git_dir
ln -s $script_dir/config $git_dir/.

cd $script_dir
#git remote set-url origin git@github.com:h-youhei/homedir.git
