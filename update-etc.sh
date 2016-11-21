#! /bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
sudo -u $USERNAME cd $script_dir

rsync -a -v -n --exclude-from=exclude-etc etc/ /etc
