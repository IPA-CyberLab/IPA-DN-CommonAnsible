#!/bin/bash

# Ver 20190808 by dnobori

set -eu

if [ $# -ne 5 ]; then
 echo Usage: se_backup_simple_dir_safe.sh nfs_address backup_subject_type backup_target_dir encryption_key max_history_count
 exit 1
fi

nfs_address=$1
backup_subject_type=$2
backup_target_dir=$3
encryption_key=$4
max_history_count=$5

se_backup_simple_dir.sh $nfs_address linux_backups/$HOSTNAME/$backup_subject_type /mnt/nfs_for_backup_$HOSTNAME $backup_target_dir $encryption_key $max_history_count

