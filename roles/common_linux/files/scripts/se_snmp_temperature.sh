#!/bin/bash

if [ "$1" = "-g" ]
then
echo .1.3.6.1.4.1.16.5.28.1.1
echo string
var_temp=`/usr/bin/sensors -u | grep temp2_input | tail -n 1`
var_temp2=`echo $var_temp | cut -d' ' -f2`
echo $var_temp2
fi
exit 0

