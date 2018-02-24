#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

dconf reset -f /desktop/ibus/
dconf load /desktop/ibus/ < $script_dir/dconf
