#!/usr/bin/sh

#firewall
systemctl enable iptables.service
systemctl enable ip6tables.service

#apach web server
systemctl enable httpd.service

#screenlock after sleep
systemctl enable xtrlock-sleep@youhei.service

#mail
systemctl enable mbsync@youhei.timer
