#!/usr/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

rsync -a -v --exclude-from=exclude-home ../home/ $HOME

cd $HOME/.emacs.d/lib
emacs --batch -L . --eval '(package-initialize)' -f batch-byte-compile-if-not-done *.el
