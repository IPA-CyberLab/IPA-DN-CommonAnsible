#!/bin/bash

if [ $# -ne 1 ]; then
 echo Usage: nic_disable_offload \<eth_name\>
 exit 1
fi

ethtool -K $1 rx off tx off sg off tso off ufo off gso off gro off lro off rxvlan on txvlan on ntuple on rxhash on > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp4 sdfn > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp6 sdfn > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1

