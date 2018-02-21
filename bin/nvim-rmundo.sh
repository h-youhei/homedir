#!/bin/sh

undofiles=`find $XDG_DATA_HOME/nvim/undo -mindepth 1 -maxdepth 1`
t_current=`date +%s`
t_3days=259200

for file in $undofiles
do
	t_modified=`stat -c %Y $file`
	t_passed=`expr "$t_current" - "$t_modified"`
	
	test "$t_passed" -gt "$t_3days" && rm $file
done

