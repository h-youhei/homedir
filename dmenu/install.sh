#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

bin() {
	ln -s $script_dir/bin/$1 $HOME/bin/
}

bin websearch
