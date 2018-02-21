#!/usr/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

rsync -a -v $XDG_CONFIG_HOME/nvim/snips ../init
