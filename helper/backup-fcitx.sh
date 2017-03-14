#!/usr/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

fcitx_from=$XDG_CONFIG_HOME/fcitx

rsync -a -v --dry-run $fcitx_from/config $fcitx_from/conf $fcitx_from/addon ../init/fcitx
