#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: se_add_vlan_subif <physical_if_name> <vlan_id> [parent_alias]" 1>&2
  exit 1
fi

physical_if_name=$1
vlan_id=$2
parent_alias=$3

if [ -z "$parent_alias" ]; then
  parent_alias=$physical_if_name
fi

ip link add name v-$parent_alias-$vlan_id type bridge ageing_time {{ lxd_bridge_ageing_time }} stp_state 0 mcast_snooping 0 mcast_router 0
echo 0 > /sys/devices/virtual/net/v-$parent_alias-$vlan_id/bridge/nf_call_iptables
echo 0 > /sys/devices/virtual/net/v-$parent_alias-$vlan_id/bridge/nf_call_ip6tables
echo 0 > /sys/devices/virtual/net/v-$parent_alias-$vlan_id/bridge/nf_call_arptables
sysctl -w net.ipv6.conf.v-$parent_alias-$vlan_id.disable_ipv6=1
ip link set v-$parent_alias-$vlan_id up promisc on

ip link add link $physical_if_name name s-$parent_alias-$vlan_id type vlan protoco 802.1Q id $vlan_id
ip link set s-$parent_alias-$vlan_id up promisc on
sysctl -w net.ipv6.conf.s-$parent_alias-$vlan_id.disable_ipv6=1

ip link set dev s-$parent_alias-$vlan_id master v-$parent_alias-$vlan_id

