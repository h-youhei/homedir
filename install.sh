#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

test -z "$SUDO_USER" && exit

./install-etc.sh
sudo -u $SUDO_USER ./install-home.sh
