#!/bin/bash
if [ "$1" = "-g" ]
then
echo .1.3.6.1.4.1.16.5.28.1.1
echo string
var_temp=`cat /sys/class/thermal/thermal_zone0/temp`
echo "scale=4; $var_temp/1000" | bc
fi
exit 0
