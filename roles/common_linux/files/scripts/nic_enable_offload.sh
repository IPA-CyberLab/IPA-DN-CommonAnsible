#!/bin/bash

if [ $# -ne 1 ]; then
 echo Usage: nic_enable_offload \<eth_name\>
 exit 1
fi

ethtool -K $1 rx on tx on sg on tso on ufo on gso on gro on lro on rxvlan on txvlan on ntuple on rxhash on > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp4 sdfn > /dev/null 2>&1
ethtool --config-nfc $1 rx-flow-hash udp6 sdfn > /dev/null 2>&1
ethtool --pause $1 autoneg off rx off tx off > /dev/null 2>&1

