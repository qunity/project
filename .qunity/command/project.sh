#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="project"
DESK="General group of project commands"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    ${NAME}:command [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
$(color 33 "Commands:")\n$(commands "./${NAME}")"

EXEC=( "execute ${NAME} --help" )
