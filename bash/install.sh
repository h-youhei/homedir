#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s $script_dir/bash_profile $HOME/.bash_profile
ln -s $script_dir/bashrc $HOME/.bashrc
