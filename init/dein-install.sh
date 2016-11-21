#!/bin/sh
curl -O https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
chmod 755 installer.sh
./installer.sh $XDG_CACHE_HOME/dein
test $? -eq 0 && rm installer.sh
