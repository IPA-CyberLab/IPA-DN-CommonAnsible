#!/bin/bash

if [ $# -ne 1 ]; then
 echo Usage: init_rss.sh \<eth_name\>
 exit 1
fi

ethtool -K $1 rx off tx off sg off tso off ufo off gso off gro off lro off rxvlan on txvlan on ntuple on rxhash on > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp4 sdfn > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp6 sdfn > /dev/null 2>&1
ethtool --set-ring $1 rx 4096 tx 4096 > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1

sleep 1
ethtool -r $1 > /dev/null 2>&1
sleep 1
ethtool -r $1 > /dev/null 2>&1
sleep 1
ethtool -r $1 > /dev/null 2>&1
sleep 1

# 2 CPUs
for i in {0..63} ; do
  (echo "3" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "3" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 4 CPUs
for i in {0..63} ; do
  (echo "f" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "f" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 8 CPUs
for i in {0..63} ; do
  (echo "ff" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "ff" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 16 CPUs
for i in {0..63} ; do
  (echo "ffff" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "ffff" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 24 CPUs
for i in {0..63} ; do
  (echo "ffffff" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "ffffff" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 28 CPUs
for i in {0..63} ; do
  (echo "fffffff" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "fffffff" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

# 56 CPUs
for i in {0..63} ; do
  (echo "000000,00000000,00000000,00000000,00000000,00000000,00000000,00ffffff,ffffffff" > /sys/class/net/$1/queues/tx-${i}/xps_cpus) > /dev/null 2>&1
  (echo "000000,00000000,00000000,00000000,00000000,00000000,00000000,00ffffff,ffffffff" > /sys/class/net/$1/queues/rx-${i}/rps_cpus) > /dev/null 2>&1
  (echo 32768 > /sys/class/net/$1/queues/rx-${i}/rps_flow_cnt) > /dev/null 2>&1
done

(echo 32768 > /proc/sys/net/core/rps_sock_flow_entries) > /dev/null 2>&1

