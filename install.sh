#!/bin/bash
set -e

dir=$(pwd)

echo "------------------------------------------------------------"
echo "Installing usbmount dependencies"

sudo apt install git debhelper build-essential ntfs-3g

echo "------------------------------------------------------------"
echo "Clone, build, and install usbmount"

cd /tmp
git clone https://github.com/rbrito/usbmount.git
cd usbmount
dpkg-buildpackage -us -uc -b
cd ..
sudo apt install ./usbmount_0.0.24_all.deb
rm -rf /tmp/usbmount*


echo "------------------------------------------------------------"
echo "Configuring usbmount"

cd $dir

sudo cp 00_create_gcode_symlink /etc/usbmount/mount.d/00_create_gcode_symlink
sudo cp 00_remove_gcode_symlink /etc/usbmount/umount.d/00_remove_gcode_symlink

sudo chmod +x /etc/usbmount/mount.d/00_create_gcode_symlink
sudo chmod +x /etc/usbmount/umount.d/00_remove_gcode_symlink

sudo cp remove_symlinks.sh /usr/local/bin/remove_symlinks.sh
sudo chmod +x /usr/local/bin/remove_symlinks.sh

sudo cp remove-symlinks.service /etc/systemd/system/remove-symlinks.service

sudo systemctl daemon-reload
sudo systemctl enable remove-symlinks.service

echo "------------------------------------------------------------"
echo "Installation complete"
