#!/bin/bash
CURRENT_DIR=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))
AUTOSTART_DIR="${HOME}/.config/autostart"
mkdir -p "${AUTOSTART_DIR}"
cp "${CURRENT_DIR}/start_splore.sh" "${AUTOSTART_DIR}/"

