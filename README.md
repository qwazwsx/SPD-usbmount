# 🌟 SonicPad-Debian usbmount Configuration Script 🌟

## Automatically Mount USB Devices to the Gcode Directory

This script installs [usbmount](https://github.com/rbrito/usbmount) and configures it to mount USB devices into the `~/printer_data/gcodes` directory.

---

### 🔧 **Installation Steps**

1. **Clone the Repository:**

    Clone the repository from GitHub to your `/tmp` directory:

    ```bash
    cd /tmp
    git clone git@github.com:qwazwsx/SPD-usbmount.git
    cd SPD-usbmount
    ```

2. **Run the Install Script:**

    The `install.sh` script will:
    - Install the `usbmount` package.
    - Create the necessary configuration files for `usbmount`.
    - Set up a system service to clean up symlinks during shutdown.

    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3. **Plug in a USB Drive**
    
    ✨Observe it get automatically mounted to the `~/printer_data/gcodes/USB0` directory✨

---
### 🛠 **Customizing the Target Directory**

By default, symlinks will be created in `~/printer_data/gcodes`. To change this target directory, simply modify the `SYMLINK_DIR` variable in each of the shell scripts 
- `/etc/usbmount/mount.d/00_create_gcode_symlink`
- `/etc/usbmount/umount.d/00_remove_gcode_symlink`
- `/usr/local/bin/remove_symlinks.sh`

For example, to change the target directory:

```bash
SYMLINK_DIR="/home/sonic/custom_directory"
```

---

### 🔗 **Supporting Multiple Instances**

If you want to support multiple Klipper instances, you can point each instance to a dummy `printer_data` directory. For example:

1. The directories for different instances are already created by the Klipper install script:

    ```bash
    ~/printer1_data/gcodes
    ~/printer2_data/gcodes
    ```

2. Remove these directories and symlink them to the main `gcodes` directory:

    ```bash
    ln -s ~/printer1_data/gcodes ~/printer_data/gcodes
    ln -s ~/printer2_data/gcodes ~/printer_data/gcodes
    ```
---

### 📝 **Description of Key Scripts**

- **`00_create_gcode_symlink`**:
    - **Trigger**: When a USB device is mounted.
    - **Action**: Symlinks the specified `UM_MOUNTPOINT` to the first available `SYMLINK_DIR/USB{i}` file. Exits if a symlink already exists.

- **`00_remove_gcode_symlink`**:
    - **Trigger**: When a USB device is unmounted.
    - **Action**: Removes any symlink in `SYMLINK_DIR` that points to `UM_MOUNTPOINT`.

- **`remove_symlinks.sh`**:
    - **Trigger**: System shutdown.
    - **Action**: Removes all symlinks matching `USB*` in the specified directory.

---

### 📚 **Logs**

- **Mount/Unmount Logs**: 
    - The script logs mount and unmount activities in `/var/log/mount_unmount.log`.
  
- **usbmount Logs**: 
    - `usbmount` logs to `/var/log/syslog` to track mounting events and system messages.

---

### 📝 **Additional Notes**

- **🛠 Configure usbmount**: Ensure that `usbmount` is properly configured for your system. If needed, you can modify `usbmount`'s configuration files located at `/etc/usbmount/usbmount.conf` to add specific device types or custom mount options.
  
- **🔍 Monitor Logs**: Keep an eye on the logs to ensure everything is functioning as expected. You can use the following command to view live updates in the log:

    ```bash
    tail -f /var/log/mount_unmount.log
    ```

- **⚠️ Error Handling**: If something goes wrong, the system logs will provide useful error messages. Be sure to check `/var/log/mount_unmount.log` and `/var/log/syslog` for detailed information.

- **🎉 Enjoy Seamless USB Mounting**: With everything set up, your USB devices will automatically mount to the `gcodes` directory and be easily accessible for use in your 3D printing workflow.
