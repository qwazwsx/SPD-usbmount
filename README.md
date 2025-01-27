# SonicPad-Debian usbmount configuration script


This script installs [usbmount](https://github.com/rbrito/usbmount) and configures it with further scripting so that any USB devices appear in the `~/printer_data/gcodes` directory


```Bash
cd /tmp
git clone git@github.com:qwazwsx/SPD-usbmount.git
cd SPD-usbmount
chmod +x install.sh
./install.sh
```

`00_create_gcode_symlink` creates specified symlink in  `~/printer_data/gcodes`

`00_remove_gcode_symlink` removes specified symlink in  `~/printer_data/gcodes`

`remove_symlinks.sh` removes all symlinks in  `~/printer_data/gcodes` on shutdown

logs for the hook scripts go in `/var/log/mount_unmount.log`, while usbmount logs to `/var/log/syslog`