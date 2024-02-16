#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="install"
DESK="Install all project parts"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    project:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

EXEC=( "execute warden:start" "sleep 60"
"execute magento:install ${ARGS[*]:1}" "execute pwa:install ${ARGS[*]:1}" )
