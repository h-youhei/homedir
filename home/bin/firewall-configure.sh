#!/bin/sh

if test "$EUID" -ne 0
then
	echo 'run as root'
	exit 1
fi

###

# reset
iptables -F
iptables -X
iptables -Z

ip6tables -F
ip6tables -X
ip6tables -Z

# policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# edit from here #

#localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#already established
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#ping
iptables -A OUTPUT -p icmp -j ACCEPT

#ftp
iptables -A OUTPUT -p tcp --dport 20:21 -j ACCEPT

#ssh
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

#dns
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#dhcp
iptables -A OUTPUT -p udp --dport 67:68 -j ACCEPT

#ntp
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

#http
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

#imap
iptables -A OUTPUT -p tcp --dport 993 -j ACCEPT

#smtp
iptables -A OUTPUT -p tcp --dport 465 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 587 -j ACCEPT

#irc
iptables -A OUTPUT -p tcp --dport 194 -j ACCEPT

#git
iptables -A OUTPUT -p tcp --dport 9418 -j ACCEPT
# to here #

###


iptables-save > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

systemctl restart iptables.service
systemctl restart ip6tables.service
