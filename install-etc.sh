#! /bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
sudo -u $USERNAME cd $script_dir

./update-etc.sh
