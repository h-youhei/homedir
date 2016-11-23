#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`

ln -s /usr/share/zoneinfo/Asia/Tokyo
hwclock --systohc
echo "LANG=en_US.UTF-8\nLANG=ja_JP.UTF-8" >> /etc/locale.gen
locale-gen

$script_dir/boot-setup.sh
$script_dir/firewall-setup.sh
$script_dir/aura-install.sh

visudo
