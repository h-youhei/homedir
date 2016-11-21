#! /bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

./update.sh

xmonad_mark=$HOME/.xmonad/mark
test ! -f $xmonad_mark && echo $HOME > $xmonad_mark

systemctl --user enable ssh-agent.service
