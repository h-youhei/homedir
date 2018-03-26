#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

lesskey $script_dir/lesskey
