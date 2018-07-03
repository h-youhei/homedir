#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

dconf reset -f /org/workrave/
dconf load /org/workrave/ < $script_dir/dconf
