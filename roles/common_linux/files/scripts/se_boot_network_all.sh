#!/bin/bash

/etc/se_boot_network_boottime1.sh
/etc/se_network_dynamic.sh
/etc/se_boot_network_boottime2.sh


if [ -f /etc/se_add_static_routes.sh ]; then
  /etc/se_add_static_routes.sh
fi

if [ -f /etc/se_optional_boot.sh ]; then
  /etc/se_optional_boot.sh
fi


