#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="download"
DESK="Download all project repositories"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-f, --force" "- Forced download of repository")
$(help:string "" "  WARNING: It will delete all previously unsaved data")"

EXEC=( "execute magento:download ${ARGS[*]:1}" "execute package:download ${ARGS[*]:1}" )
