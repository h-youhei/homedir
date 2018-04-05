#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

rsync -a -v $script_dir/config1.db $HOME/.mozc
