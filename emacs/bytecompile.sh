#!/usr/bin/sh

cd $HOME/.emacs.d/lib

emacs --batch -L . --eval '(package-initialize)' -f batch-byte-compile *.el
