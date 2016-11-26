#!/bin/sh

list=`networkctl list`
echo "$list"
printf "choose network. type IDX (default 2):"
read idx
case $idx in
	"" ) idx=2 ;;
	[1-9] ) ;;
	* ) echo "type number"
		exit 1 ;;
esac

name=`echo "$list" | grep "^  *$idx" | awk '{print $2}'`

if test -z "$name"
then
	echo "not exist the network id"
	exit 1
fi

cat > /etc/systemd/network/$name.network << END 
[Match]
NAME=$name

[Network]
DHCP=yes
END
