#!/bin/bash
CURRENT_DIR=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))
AUTOSTART_DIR="${HOME}/.config/autostart"
rm -rf "${AUTOSTART_DIR}/start_splore.sh"
