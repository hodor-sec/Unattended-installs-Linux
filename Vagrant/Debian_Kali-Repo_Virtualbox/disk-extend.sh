#!/bin/bash
echo "> Installing required tools for file system management"
if  [ -n "$(command -v yum)" ]; then
    echo ">> Detected yum-based Linux"
    yum makecache
    yum install -y util-linux
    yum install -y lvm2
    yum install -y e2fsprogs
fi
if [ -n "$(command -v apt-get)" ]; then
    echo ">> Detected apt-based Linux"
    apt-get update -y
    apt-get install -y fdisk
    apt-get install -y lvm2
    apt-get install -y e2fsprogs
fi
ROOT_DISK_DEVICE="/dev/sda"
ROOT_DISK_DEVICE_PART="/dev/sda1"
FS_PATH=`df / | sed -n 2p | awk '{print $1;}'`
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "> Increasing disk size of $ROOT_DISK_DEVICE to available maximum"
resize2fs -F -p $ROOT_DISK_DEVICE_PART
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
exit 0
