#!/bin/bash

# Source predefined functions and variables
. /etc/profile

# Sound, time, locale startup from:
# /usr/bin/start_es.sh

export SDL_AUDIODRIVER=pulseaudio

TZ=$(get_setting system.timezone)
echo -n "TIMEZONE=${TZ}" > /storage/.cache/timezone
echo -n "${TZ}" >/storage/.cache/system_timezone
systemctl restart tz-data.service

MYLOCALE=$(get_setting system.language)
if [[ -n "${MYLOCALE}" ]]
then

  unset I18NPATH LANG LANGUAGE LOCPATH

  MYCHARMAP="UTF-8"
  MYLANG="${MYLOCALE}.${MYCHARMAP}"
  MYLOCPATH="/storage/.config/emulationstation"

  if [ ! -e "${MYLOCPATH}/locale/${MYLANG}/LC_NAME" ]; then
    performance
 I18NPATH="/usr/share/i18n"
 localedef -i ${MYLOCALE} \
           -c \
           -v \
           -f ${MYCHARMAP} \
           ${MYLOCPATH}/locale/${MYLANG} >/var/log/start_es.log 2>&1
    ${DEVICE_CPU_GOVERNOR}
  fi

  export LOCPATH="${MYLOCPATH}/locale"
  export LANG=${MYLANG}
  export LANGUAGE=${MYLANG}
  systemctl import-environment LANG
  systemctl import-environment LOCPATH
  systemctl import-environment I18NPATH
  systemctl import-environment LANGUAGE
fi

# Run /usr/bin/start_pico8.sh if it exists, then exit.

if [ -e "/usr/bin/start_pico8.sh" ]
then
    /usr/bin/start_pico8.sh splore
    exit
fi

# Copy of start_pico8.sh in case it doesn't exist in a future JELOS release
GAME_DIR="/storage/roms/pico-8/"

case ${HW_ARCH} in
  aarch64)
    STATIC_BIN="pico8_64"
  ;;
  *)
    STATIC_BIN="pico8_dyn"
  ;;
esac

# Splore
OPTIONS="-splore"

INTEGER_SCALE=$(get_setting pico-8.integerscale)
if [ "${INTEGER_SCALE}" = "1" ]
then
  OPTIONS="${OPTIONS} -pixel_perfect 1"
fi

if [ -d "${GAME_DIR}/${HW_ARCH}" ]
then
  LAUNCH_DIR="${GAME_DIR}/${HW_ARCH}"
else
  LAUNCH_DIR="${GAME_DIR}"
fi

# store sdl_controllers in root directory so its shared across devices - will look to revisit this with controller refactor work
cp -f /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt ${GAME_DIR}/sdl_controllers.txt

# mark the binary executable to cover cases where the user adding the binaries doesn't know or forgets.
chmod 0755 ${LAUNCH_DIR}/${STATIC_BIN}
jslisten set "-9 ${STATIC_BIN} start_pico8.sh"
${LAUNCH_DIR}/${STATIC_BIN} -home -root_path ${GAME_DIR} -joystick 0 ${OPTIONS} "${CART}"
