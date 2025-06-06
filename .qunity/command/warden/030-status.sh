#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="warden:status"
DESK="Check status Warden environment"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

warden:status() {
  if ! warden status | grep -qF -e "$WARDEN_ENV_NAME" -e "$WARDEN_ENV_TYPE" ||
     ! warden:exec php --version &> /dev/null || ! warden:exec composer --version &> /dev/null
  then return 1; fi
}
