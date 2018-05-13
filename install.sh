#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

# order is consern
xdg/install.sh
sh-common/install.sh
bash/install.sh
zsh/install.sh
systemd/install.sh
X11/install.sh


ripgrep/install.sh
tmux/install.sh
vim/install.sh
fontconfig/install.sh
xmonad/install.sh
stalontray/install.sh
xterm/install.sh
ibus/install.sh
mozc/install.sh
tig/install.sh
pacman/install.sh
gtk/install.sh
qutebrowser/install.sh

[ -d $HOME/bin ] || mkdir $HOME/bin
bin() {
	ln -s "$script_dir/bin/$1" $HOME/bin/
}
