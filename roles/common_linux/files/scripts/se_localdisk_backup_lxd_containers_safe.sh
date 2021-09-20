#!/bin/bash

# Ver 20210920 by dnobori

set -eu

if [ $# -ne 6 ]; then
 echo Usage: se_localdisk_backup_lxd_containers_safe.sh backup_subject_type localdisk_subdir localdisk_mountpoint vmdata_root_dir encryption_key max_history_count
 exit 1
fi

backup_subject_type=$1
localdisk_subdir=$2
localdisk_mountpoint=$3
vmdata_root_dir=$4
encryption_key=$5
max_history_count=$6

cd /tmp/

find $vmdata_root_dir/containers/ -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | xargs -n 1 -t -P 1 -IXXX se_localdisk_backup_simple_dir.sh $localdisk_subdir/vmdata_backups/$HOSTNAME/$backup_subject_type/XXX/ $localdisk_mountpoint $vmdata_root_dir/containers/XXX/ $encryption_key $max_history_count

