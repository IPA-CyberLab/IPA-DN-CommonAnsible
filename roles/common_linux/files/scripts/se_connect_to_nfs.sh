#!/bin/bash

if [ $# -ne 3 ]; then
 echo Usage: connect_to_nfs.sh server_ip server_mount_name client_mount_point
 exit 1
fi

apt-get -y install nfs-common

server_ip=$1
server_mount_name=$2
client_mount_point=$3

while true
do
  if (mountpoint -q $client_mount_point); then
    break
  fi
  
  mkdir -p $client_mount_point

  mount -o soft,retrans=3,vers=3,tcp,timeo=600,rsize=1048576,wsize=1048576,noac,retry=0,nolock,noacl,local_lock=none -t nfs $server_ip:$server_mount_name $client_mount_point
  
  if (mountpoint -q $client_mount_point); then
    break
  fi

  sleep 5
  
done

sleep 1

