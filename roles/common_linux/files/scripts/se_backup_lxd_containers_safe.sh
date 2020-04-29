#!/bin/bash

# Ver 20200430 by dnobori

set -eu

if [ $# -ne 5 ]; then
 echo Usage: se_backup_lxd_containers_safe.sh nfs_address backup_subject_type vmdata_root_dir encryption_key max_history_count
 exit 1
fi

nfs_address=$1
backup_subject_type=$2
vmdata_root_dir=$3
encryption_key=$4
max_history_count=$5

cd /tmp/

find $vmdata_root_dir/containers/ -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | xargs -n 1 -t -P 1 -IXXX se_backup_simple_dir.sh $nfs_address vmdata_backups/$HOSTNAME/$backup_subject_type/XXX/ /mnt/nfs_for_container_backup_$HOSTNAME $vmdata_root_dir/containers/XXX/ $encryption_key $max_history_count

