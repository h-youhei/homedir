#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME=$HOME/.config
xmonad_dir=$XDG_CONFIG_HOME/xmonad
[ -d $xmonad_dir ] || mkdir -p $xmonad_dir

ln -s $script_dir/xmonad.hs $xmonad_dir/.
ln -s $script_dir/lib $xmonad_dir/.

ln -s $script_dir/xmobar $XDG_CONFIG_HOME/.

ln -sf $script_dir/xinit.sh $XDG_CONFIG_HOME/X11/xinitrc.d/99-window-manager.sh

command -v xmonad && xmonad --recompile
