#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s $script_dir/profile $HOME/.profile

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
ln -s $script_dir/locale.conf $XDG_CONFIG_HOME/

sh_common_dir=$XDG_CONFIG_HOME/sh-common
[ -d $sh_common_dir ] || mkdir -p $sh_common_dir
[ -d $sh_common_dir/alias.d ] || mkdir $sh_common_dir/alias.d

ln -s $script_dir/alias.sh $sh_common_dir/
ln -s $script_dir/dir_colors $sh_common_dir/
