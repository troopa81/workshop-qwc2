#/usr/bin/env bash

set -e

DEV=/dev/sdb
PART=${DEV}1
MNTPT=/media/usb
OVAFILE=workshop-qwc2.ova
MD5FILE=${OVAFILE}.md5

while /bin/true; do
    read -p "create key? [yes|no] " yn
    case $yn in
    [Nn]* )
        exit
        ;;
    [Yy]* ) 
        echo "create partition..."
        echo "type=7" | sudo sfdisk $DEV > /dev/null
        echo "create file system..."
        sudo mkfs.exfat $PART > /dev/null
        echo "mount device..."
        sudo mount $PART $MNTPT
        echo "copy files to device..."
        time cp $OVAFILE $MD5FILE $MNTPT/
        echo "check md5..."
        md5sum -c $MNTPT/$MD5FILE
        echo "unmount device..."
        sudo umount $MNTPT
        ;;
    esac
done
