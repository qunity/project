#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="download"
DESK="Download project repositories"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    project:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data"

EXEC=( "execute magento:download ${ARGS[*]:1}" "execute pwa:download ${ARGS[*]:1}"
"execute package:download ${ARGS[*]:1}" )
