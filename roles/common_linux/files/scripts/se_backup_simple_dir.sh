#!/bin/bash

# Ver 20190808 by dnobori

set -eu

apt-get -y install nfs-common || true

logfile="/root/se_backup.log"

if [ $# -ne 6 ]; then
 echo Usage: se_backup_simple_dir.sh nfs_address nfs_subdir local_mount_point backup_target_dir encryption_key max_history_count
 exit 1
fi

nfs_address=$1
nfs_subdir=$2
local_mount_point=$3
backup_target_dir=$4
encryption_key=$5
max_history_count=$6

timestamp=`date "+%Y%m%d_%H%M%S"`

umount -f $local_mount_point || true
mkdir -p $local_mount_point
chmod 700 $local_mount_point

echo "--- START BACKUP ---" >> $logfile
date >> $logfile
echo nfs_address=$nfs_address >> $logfile
echo nfs_subdir=$nfs_subdir >> $logfile
echo local_mount_point=$local_mount_point >> $logfile
echo backup_target_dir=$backup_target_dir >> $logfile
echo encryption_key=$encryption_key >> $logfile
echo max_history_count=$max_history_count >> $logfile

mount -o soft,vers=3,tcp,rsize=65500,wsize=65500 -t nfs $nfs_address $local_mount_point

mountpoint $local_mount_point
echo "Mount OK" >> $logfile

# Delete other ng dirs
echo "Delete other ng dirs" >> $logfile

find $local_mount_point/$nfs_subdir -maxdepth 1 -mindepth 1 -name '*.ng' -type d | xargs -L 1 rm -fr

# Execute backup
echo "Execute backup" >> $logfile

echo output_dir=$local_mount_point/$nfs_subdir/$timestamp.ng >> $logfile

mkdir -p $local_mount_point/$nfs_subdir/$timestamp.ng
cd $local_mount_point/$nfs_subdir/$timestamp.ng

tar cpflz - --directory $backup_target_dir ./ | openssl enc -e -aes256 -k $encryption_key | split -b 1000000000 -a 6

mkdir -p $local_mount_point/$nfs_subdir/$timestamp.ng/info/

ifconfig -a > $local_mount_point/$nfs_subdir/$timestamp.ng/info/ifconfig.txt
mount > $local_mount_point/$nfs_subdir/$timestamp.ng/info/mount.txt
cp /etc/fstab $local_mount_point/$nfs_subdir/$timestamp.ng/info/fstab.txt
df -a > $local_mount_point/$nfs_subdir/$timestamp.ng/info/df.txt
uname -a > $local_mount_point/$nfs_subdir/$timestamp.ng/info/uname.txt
free > $local_mount_point/$nfs_subdir/$timestamp.ng/info/free.txt
fdisk -l > $local_mount_point/$nfs_subdir/$timestamp.ng/info/fdisk.txt

# Finalize
echo "Finalize" >> $logfile
mv $local_mount_point/$nfs_subdir/$timestamp.ng $local_mount_point/$nfs_subdir/$timestamp.ok


# Delete old dirs
echo "Delete old dirs" >> $logfile
find $local_mount_point/$nfs_subdir -maxdepth 1 -mindepth 1 -name '*.ok' -type d | sort -r | awk 'NR>'$max_history_count | xargs -L 1 rm -fr


echo "Completed" >> $logfile
date >> $logfile
echo "--- END BACKUP ---" >> $logfile

