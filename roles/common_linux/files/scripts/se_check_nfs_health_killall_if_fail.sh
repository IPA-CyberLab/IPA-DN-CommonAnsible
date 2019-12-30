#!/bin/bash

if [ $# -ne 2 ]; then
 echo Usage: se_check_nfs_health_killall_if_fail.sh client_mount_point killprogram
 exit 1
fi

client_mount_point=$1
killprogram=$2

target_dir=$client_mount_point/.write_check/
target_filename=$target_dir/$(hostname).txt

while true
do
  mkdir -p $target_dir
  echo test > $target_filename
  if [ $? -ne 0 ]; then
    logger se_check_nfs_health_killall_if_fail Error. Failed to write $target_filename
    break
  fi
  sleep 1
done

logger Killing $killprogram by se_check_nfs_health_killall_if_fail

/usr/bin/killall -KILL $killprogram
sleep 1

/usr/bin/killall -KILL $killprogram
sleep 1

/usr/bin/killall -KILL $killprogram



