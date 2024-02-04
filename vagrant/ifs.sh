#!/bin/bash -e

if=
dev=
ip4=
ip6=

state=if
while read line; do 
	if [[ "$line" =~ ^Hardware ]]; then
		if [ -n "$ip4" ]; then
			#echo "${if// /\ } $dev ${ip4:-na} ${ip6:-na}"
			echo "${if// /\ }"
			if=
			dev=
			ip4=
			ip6=
		fi
		if=$(echo "$line" | cut -d" " -f3-)
		state=device
		continue
	fi

	if [ "$state" = "device" ]; then
		dev=$(echo "$line" | cut -d" " -f2-)
		ip4=$(ifconfig $dev | grep inet\ | awk '{ print $2 }')
		ip6=$(ifconfig $dev | grep inet6\ | awk '{ print $2 }')
		state=skip
		continue
	fi
done < <(networksetup -listallhardwareports)

if [ -n "$ip4" ]; then
	echo "${if// /\ }"
fi
