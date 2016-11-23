#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

d_entries=/boot/loader/entries
install -m 755 boot/loader.conf /boot/loader
install -m 755 boot/entries/arch-lts.conf boot/entries/arch.conf $d_entries

partition=`findmnt -l | grep '/ ' | awk '{print $2}'`
uuid=`blkid | grep $partition | awk '{print $6}' | sed 's/"//g'`
echo "options root=$uuid rw" >> $d_entries/arch.conf >> /$d_entries/arch-lts.conf
