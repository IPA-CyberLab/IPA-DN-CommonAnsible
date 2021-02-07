#!/bin/bash
init_interval=3
interval=$init_interval
maxinterval=600

ntp_servers="supertime1.ntp.ipantt.net supertime1-v6.ntp.ipantt.net supertime2.ntp.ipantt.net supertime2-v6.ntp.ipantt.net supertime3.ntp.ipantt.net supertime3-v6.ntp.ipantt.net supertime4.ntp.ipantt.net supertime4-v6.ntp.ipantt.net external1.ntp.ipantt.net external1-v6.ntp.ipantt.net external2.ntp.ipantt.net external2-v6.ntp.ipantt.net 133.243.238.244 210.173.160.27 2001:df0:232:eea0::fff4 2001:3a0:0:2001::27:123 ntteast-ntp1.ngn.open.ad.jp ntteast-ntp2.ngn.open.ad.jp 2404:1a8:1102::a 2404:1a8:1102::b 2408:211:c0e9:5300:16:4ff:fe14:302 2408:210:2ca2:4a00:16:4ff:fe14:402"

while true
do
 interval=$((++interval))
 if [ $interval -gt $maxinterval ]; then
   interval=$maxinterval
 fi
 ntpdate -u $ntp_servers
 if [ $? -eq 0 ]; then
   systemctl stop ntp-systemd-netif.service || true
   systemctl stop ntp.service || true
   ps aux | grep -F /var/run/ntpd.pid | grep -F /usr/sbin/ntpd | grep -v grep | awk '{ print "kill -KILL", $2 }' | sh || true
   systemctl restart fake-hwclock || true
   /usr/sbin/hwclock -w || true
 else
   interval=$init_interval
 fi
 sleep $interval
done

EOF

