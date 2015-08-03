#!/bin/sh

#
# Helper function to create a temporary file system
# TODO: Implement support for more operating systems
#
mkramfs() {
  # Create temporary mount point
  mnt=$(mktemp -d tmp.XXXXXXXX)
  # Mount temporary file system
  if [ "$(uname)" = "Linux" ]; then
    sudo mount -t ramfs -o mode=777 ramfs $mnt
  elif [ "$(uname)" = "Darwin" ]; then
    # Create a RAM disk.
    ramfs_size_sectors=$((10*1024*1024/512))
    ramdisk_dev=`hdid -nomount ram://${ramfs_size_sectors}`
    # Create a file system on the RAM disk and mount it.
    newfs_hfs -v 'ram disk' ${ramdisk_dev} > /dev/null 2>&1
    mount -o noatime -t hfs ${ramdisk_dev} ${mnt}
  fi
  # Return the mount point
  echo $mnt
}

#
# Helper function to remove a temporary file system
# TODO: Implement support for more operating systems
#
rmramfs() {
  # Unmount temporary file system
  if [ "$(uname)" = "Linux" ]; then
    sudo umount $1
  elif [ "$(uname)" = "Darwin" ]; then
    umount $1
  fi
  # Remove temporary mount point
  rm -rf $1
}
