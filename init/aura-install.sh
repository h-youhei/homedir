#!/bin/sh
curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/aura-bin.tar.gz
tar -xvf aura-bin.tar.gz
cd aura-bin
makepkg -sci
ret=$?
cd ..
test $ret -eq 0 && rm -r aura-bin.tar.gz aura-bin
