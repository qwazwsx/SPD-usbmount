# SonicPad-Debian usbmount configuration script

## Automatically mount USB devices to the gcode directory

This script installs [usbmount](https://github.com/rbrito/usbmount) and configures it to mount USB devices in the `~/printer_data/gcodes` directory


```Bash
cd /tmp
git clone git@github.com:qwazwsx/SPD-usbmount.git
cd SPD-usbmount
chmod +x install.sh
./install.sh
```

The install script will clone, build, and install usbmount; create neccessary configuration files for usbmount; add system service that cleans up symlinks on shutdown

`00_create_gcode_symlink` creates specified symlink in  `~/printer_data/gcodes`

`00_remove_gcode_symlink` removes specified symlink in  `~/printer_data/gcodes`

`remove_symlinks.sh` removes all symlinks in  `~/printer_data/gcodes` on shutdown

logs for the hook scripts go in `/var/log/mount_unmount.log`, while usbmount logs to `/var/log/syslog`

you can configure the target directory by changing the `SYMLINK_DIR` variable in each shell script
