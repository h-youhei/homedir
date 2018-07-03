#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

dconf dump /org/workrave/ > $script_dir/dconf
