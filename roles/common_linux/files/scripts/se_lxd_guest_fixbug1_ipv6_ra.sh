#!/bin/bash

if [ $# -ne 1 ]; then
 echo Usage: se_lxd_guest_fixbug1_ipv6_ra \<eth_name\>
 exit 1
fi

# Fix lxd container bug

while [ 1 ];
do
	sysctl -w net.ipv6.conf.$1.accept_ra=1 >& /dev/null
	sleep 60
done

