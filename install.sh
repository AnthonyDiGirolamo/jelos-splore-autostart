#!/bin/bash
CURRENT_DIR=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))
AUTOSTART_DIR="${HOME}/.config/autostart"
SCRIPT=start_splore.sh
mkdir -p "${AUTOSTART_DIR}"
cp -v "${CURRENT_DIR}/${SCRIPT}" "${AUTOSTART_DIR}/"
echo Installed: "${AUTOSTART_DIR}/${SCRIPT}"

