#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="warden:status"
DESK="Check status Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

warden:status() {
  if ! warden status | grep -qF -e "$WARDEN_ENV_NAME" -e "$WARDEN_ENV_TYPE"; then return 1; fi;

  if ! warden:exec php --version >> /dev/null; then return 1; fi;
  if ! warden:exec composer --version >> /dev/null; then return 1; fi;
}
