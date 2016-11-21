#! /bin/sh
script_path=`readlink -f $0`
script_dir=`dirname $script_path`

cd $script_dir/init

sudo -u $USERNAME ./aura-install&
sudo -u $USERNAME ./dein-install.sh&

