#!/bin/bash

/etc/se_boot_network_boottime1.sh
/etc/se_network_dynamic.sh
/etc/se_boot_network_boottime2.sh
/etc/se_add_static_routes.sh

/etc/se_optional_boot.sh


