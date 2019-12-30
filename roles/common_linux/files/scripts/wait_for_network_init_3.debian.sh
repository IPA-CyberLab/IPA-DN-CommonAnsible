#!/bin/bash
echo wait_for_network_system_init3: Start.
current_count=0
while [ ! -f /run/network/ifstate ]
do
  current_count=$[$current_count+1]
  if [[ $current_count -gt 60 ]]; then
    echo wait_for_network_system_init3: Timed out.
    break
  fi
  sleep 1
done
unset current_count
sleep 1
echo wait_for_network_system_init3: End.
