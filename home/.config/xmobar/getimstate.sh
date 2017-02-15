#!/bin/sh

imstate=`fcitx-remote`

case $imstate in
	2) output='JP' ;;
	*) output='EN' ;;
esac

echo $output

exit 0
