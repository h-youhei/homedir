#!/bin/sh

script_path=`readlink -f $0`
script_dir=`dirname $script_path`
cd $script_dir

./update-etc.sh

#apach web server
systemctl enable httpd.service

systemctl enable xtrlock-sleep@youhei.service
