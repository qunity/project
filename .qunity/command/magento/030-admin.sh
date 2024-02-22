#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="magento:admin"
DESK="Magento website admin commands group"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} [command] [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(style 33 "Commands:")\n$(help:commands "$NAME")"

EXEC=( "execute ${NAME} --help" )
