#!/bin/bash
CURRENT_DIR=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))
AUTOSTART_DIR="${HOME}/.config/autostart"
SCRIPT=start_splore.sh
rm -rvf "${AUTOSTART_DIR}/${SCRIPT}"
echo Removed: "${AUTOSTART_DIR}/${SCRIPT}"
