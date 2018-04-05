#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

rsync -a -v $HOME/.mozc/config1.db $script_dir
