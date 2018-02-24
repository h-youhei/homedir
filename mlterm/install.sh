#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s $script_dir/main $HOME/.mlterm/.
ln -s $script_dir/aafont $HOME/.mlterm/.
