#!/bin/bash
# removes all symlinks matching USB* in the specified directory
set -e

SYMLINK_DIR="/home/sonic/printer_data/gcodes"

for symlink in "$SYMLINK_DIR"/USB*; do
    if [ -L "$symlink" ]; then
        rm -f "$symlink"
        echo "Removed symlink: $symlink"
    fi
done