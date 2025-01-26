#!/bin/bash
set -e

echo "------------------------------------------------------------"
echo "Uninstalling usbmount"
sudo apt remove usbmount

echo "------------------------------------------------------------"
echo "Removing usbmount dependencies"
sudo apt remove git debhelper build-essential ntfs-3g

echo "------------------------------------------------------------"
echo "Removing usbmount configuration"
sudo rm /etc/usbmount/mount.d/00_create_gcode_symlink
sudo rm /etc/usbmount/umount.d/00_remove_gcode_symlink
sudo rm /usr/local/bin/remove_all_gcode_symlinks.sh

sudo systemctl disable remove-symlinks.service
sudo rm /etc/systemd/system/remove_all_gcode_symlinks.service
sudo systemctl daemon-reload

echo "------------------------------------------------------------"
echo "Uninstall complete"