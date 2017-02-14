#!/bin/sh

imstate=`fcitx-remote`

case $imstate in
	2) output='日' ;;
	*) output='英' ;;
esac

echo $output

exit 0
