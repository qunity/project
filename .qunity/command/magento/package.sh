#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="package"
DESK="Magento website package(s) command group"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    magento:${NAME}:command [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
$(color 33 "Commands:")\n$(commands "./magento/${NAME}")"

EXEC=( "execute magento:${NAME} --help" )
