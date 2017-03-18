#!/usr/bin/sh

#apach web server
systemctl enable httpd.service

#screenlock after sleep
systemctl enable xtrlock-sleep@youhei.service

#mail
systemctl enable mbsync@youhei.timer
