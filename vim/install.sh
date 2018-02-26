#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

vim_dir=$HOME/.vim
[ -d $vim_dir ] || mkdir $vim_dir

ln -s $script_dir/vimrc $vim_dir/.
ln -s $script_dir/after $vim_dir/.
ln -s $script_dir/autoload $vim_dir/.
ln -s $script_dir/conf.d $vim_dir/.
