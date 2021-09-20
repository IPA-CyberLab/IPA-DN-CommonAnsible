#!/bin/bash

# Ver 20210920 by dnobori

set -eu

logfile="/root/se_backup_localdisk.log"

if [ $# -ne 5 ]; then
 echo Usage: se_localdisk_backup_simple_dir.sh localdisk_subdir localdisk_mountpoint backup_target_dir encryption_key max_history_count
 exit 1
fi

localdisk_subdir=$1
localdisk_mountpoint=$2
backup_target_dir=$3
encryption_key=$4
max_history_count=$5

timestamp=`date "+%Y%m%d_%H%M%S"`

echo "--- START BACKUP ---" >> $logfile
date >> $logfile
echo localdisk_subdir=$localdisk_subdir >> $logfile
echo localdisk_mountpoint=$localdisk_mountpoint >> $logfile
echo backup_target_dir=$backup_target_dir >> $logfile
echo encryption_key=$encryption_key >> $logfile
echo max_history_count=$max_history_count >> $logfile

mountpoint $localdisk_mountpoint
echo "Mount OK" >> $logfile

# Delete other ng dirs
echo "Delete other ng dirs" >> $logfile

find $localdisk_mountpoint/$localdisk_subdir -maxdepth 1 -mindepth 1 -name '*.ng' -type d | xargs -L 1 rm -fr

# Execute backup
echo "Execute backup" >> $logfile

echo output_dir=$localdisk_mountpoint/$localdisk_subdir/$timestamp.ng >> $logfile

mkdir -p $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng
cd $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng

tar cpflz - --directory $backup_target_dir ./ | openssl enc -e -aes256 -k $encryption_key | split -b 1000000000 -a 6

mkdir -p $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/

ifconfig -a > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/ifconfig.txt
mount > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/mount.txt
cp /etc/fstab $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/fstab.txt
df -a > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/df.txt
uname -a > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/uname.txt
free > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/free.txt
fdisk -l > $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng/info/fdisk.txt

# Finalize
echo "Finalize" >> $logfile
mv $localdisk_mountpoint/$localdisk_subdir/$timestamp.ng $localdisk_mountpoint/$localdisk_subdir/$timestamp.ok


# Delete old dirs
echo "Delete old dirs" >> $logfile
find $localdisk_mountpoint/$localdisk_subdir -maxdepth 1 -mindepth 1 -name '*.ok' -type d | sort -r | awk 'NR>'$max_history_count | xargs -L 1 rm -fr


echo "Completed" >> $logfile
date >> $logfile
echo "--- END BACKUP ---" >> $logfile

