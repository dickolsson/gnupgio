#!/bin/sh

#
# Helper function to create a temporary file system
# TODO: Implement support for more operating systems
#
mkramfs() {
  # Create temporary mount point
  mnt=$(mktemp -d)
  # Mount temporary file system
  if [ "$(uname)" = "Linux" ]; then
    sudo mount -t ramfs -o mode=777 ramfs $mnt
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
  fi
  # Remove temporary mount point
  rm -rf $1
}
