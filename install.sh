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
cd $dir
echo "Configuring usbmount"

cp 00_create_gcode_symlink /etc/usbmount/mount.d/00_create_gcode_symlink
cp 00_remove_gcode_symlink /etc/usbmount/umount.d/00_remove_gcode_symlink

chmod +x /etc/usbmount/mount.d/00_create_gcode_symlink
chmod +x /etc/usbmount/umount.d/00_remove_gcode_symlink

cp remove_all_gcode_symlinks.sh /usr/local/bin/remove_all_gcode_symlinks.sh
chmod +x /usr/local/bin/remove_all_gcode_symlinks.sh

cp remove_all_gcode_symlinks.service /etc/systemd/system/remove_all_gcode_symlinks.service

sudo systemctl daemon-reload
sudo systemctl enable remove-symlinks.service

echo "------------------------------------------------------------"
echo "Installation complete"
