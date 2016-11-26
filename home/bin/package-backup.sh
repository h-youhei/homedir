#!/bin/sh

case $# in
	1 )
		break ;;
	0 )
		echo "pass me output path"
		exit 1 ;;
	* )
		echo "too many argument"
		exit 1 ;;
esac

test ! -e "$1" && mkdir -p $1
cd $1
if test "$?" -ne 0
then
	echo "you passed me not a directory"
	exit 1
fi

#get package list
pacman -Qqe > all.plst
pacman -Qqg | grep '^base \|^base-devel ' | awk '{print $2}' > base.plst
pacman -Qqg | grep '^user ' | awk '{print $2}' > abs.plst
pacman -Qqm > aur.plst

#exclude base, aur, abs packages from main list
cat all.plst | grep -v "`cat base.plst`" | grep -v "`cat aur.plst`" | grep -v "`cat abs.plst`" > main.plst

rm base.plst all.plst
