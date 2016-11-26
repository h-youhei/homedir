#!/bin/sh

if test "$EUID" -ne 0
then
	echo 'run as root'
	exit 1
fi

###

# edit from here #
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP


ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP
ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP
# to here #

###


iptables-save > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

isenable=`systemctl is-enable iptables.service`
test "$isenable" = 'disabled' && systemctl enable iptables.service
isenable=`systemctl is-enable ip6tables.service`
test "$isenable" = 'disabled' && systemctl enable ip6tables.service
systemctl restart iptables.service
systemctl restart ip6tables.service
