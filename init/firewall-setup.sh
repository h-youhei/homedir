#!/bin/sh

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP


ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP
ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP

iptables-save > /etc/iptables/iptables.rules
ip6tables-save > /etc/iptables/ip6tables.rules

systemctl enable iptables
systemctl enable ip6tables
