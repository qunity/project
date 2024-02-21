#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="magento"
DESK="Magento website commands group"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} [command] [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(color 33 "Commands:")\n$(help:commands "$NAME")"

EXEC=( "execute ${NAME} --help" )
