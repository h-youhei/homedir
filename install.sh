#!/usr/bin/sh

test -z "$SUDO_USER" && exit

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

./update.sh

cd helper
./install-etc.sh
sudo -u $SUDO_USER ./install-home.sh
