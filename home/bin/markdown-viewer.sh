#!/bin/sh

case $# in
	1 ) ;;
	0 )
		echo "select some file"
		exit 1 ;;
	* ) echo "too many argument"
		exit 1 ;;
esac

fname=`basename $1`
tempf=/tmp/$fname.tmp

pandoc -f markdown_github -o $tempf $1
if $ret
then
	firefox $tempf
fi
