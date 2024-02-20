#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="package"
DESK="Magento website package(s) commands group"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options] [arguments]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(color 33 "Commands:")\n$(help:commands "$NAME")"

EXEC=( "execute ${NAME} --help" )
