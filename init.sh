#!/usr/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir/init

sudo -u $SUDO_USER ./dein-install.sh

sudo -u $SUDO_USER cp .gitconfig $HOME
sudo -u $SUDO_USER rsync -a -v fcitx/ $XDG_CONFIG_HOME/fcitx
