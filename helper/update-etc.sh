#!/usr/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

rsync -rlpt -v --exclude-from=exclude-etc ../etc/ /etc
