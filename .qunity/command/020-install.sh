#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="install"
DESK="Install all project components"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

EXEC=( "execute warden:up" "execute magento:install ${ARGS[*]:1}" )
