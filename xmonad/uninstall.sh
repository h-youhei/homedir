#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
xmonad_dir=$XDG_CONFIG_HOME/xmonad

unlink $xmonad_dir/xmonad.hs
unlink $xmonad_dir/lib

unlink $XDG_CONFIG_HOME/xmobar
rm -r $xmonad_dir
