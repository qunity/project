#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="package"
DESK="Magento package command group"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    command [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
$(color 33 "Commands:")\n$(commands "./${NAME}")"

EXEC=( "execute '${NAME}' --help" )
