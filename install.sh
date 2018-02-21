#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

xdg/install.sh
zsh/install.sh
X11/install.sh 
xmonad/install.sh
stalontray/install.sh
urxvt/install.sh
fcitx/install.sh
mozc/install.sh

[ -d $HOME/bin ] || mkdir $HOME/bin
bin() {
	ln -s "$script_dir/bin/$1" $HOME/bin/.
}
