#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

if test -n "$SUDO_USER"
then
	./update-etc.sh
	sudo -u $SUDO_USER ./update-home.sh
else
	./update-home.sh
fi
