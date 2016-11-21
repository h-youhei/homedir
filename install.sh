#! /bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

rsync -a -v -n --exclude-from=exclude home/ $HOME

xmonad_mark=$HOME/.xmonad/mark
test ! -f $xmonad_mark && echo $HOME > $xmonad_mark
