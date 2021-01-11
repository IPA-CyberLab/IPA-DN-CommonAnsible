#!/bin/bash

c1=$(ps aux | grep -F /etc/se_ntpdate_loop.sh | grep -v grep | wc -l)

if [ $c1 -ne 0 ]; then
  echo se_ntpdate_loop.sh is already running.
  exit 0;
fi

nohup /etc/se_ntpdate_loop.sh > /dev/null 2>&1 &

