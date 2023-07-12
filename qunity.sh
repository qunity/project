#!/usr/bin/env bash
# shellcheck source=./.qunity/[*/]*.sh

set -o nounset -o errexit

readonly VERSION="v2.0.2-dev"
readonly BASE_DIR="$(realpath "$(dirname "$0")")"
readonly QUNITY_DIR="${BASE_DIR}/.qunity"

if [[ -f "${BASE_DIR}/.env" ]]; then source "${BASE_DIR}/.env"; fi
if [[ -f "${QUNITY_DIR}/.env" ]]; then source "${QUNITY_DIR}/.env"; fi

color() { echo -n "\033[${1}m${*:2}\033[0m"; }; print() { echo -e "$(date +'%T') ${*}"; }

commands() { local FILE; while read -r FILE; do unset "NAME" "DESK"; source "$FILE"
  printf "%${2-4}s%$(( ${3-20} * -1 ))s - %s\n" "" "${NAME-"$(basename "$FILE")"}" "${DESK-"..."}"
done < <(ls "${QUNITY_DIR}/command/${1//":"/"/"}"/*.sh 2> /dev/null); }

arg:has() { local ARG; for ARG in "${@:2}"; do
  if [[ "$ARG" == "${1%%":"*}" || "$ARG" == "${1##*":"}" ]]; then return 0; fi
done; return 1; }

arg:get() { local RESULT=() SEARCH ARG; for ARG in "${@:2}"; do if [[ -z "${SEARCH-}" ]]; then
  if [[ "$ARG" == "${1%%":"*}" || "$ARG" == "${1##*":"}" ]]; then SEARCH="true"; fi
  continue; fi; if [[ "$ARG" == "-"* ]]; then break; fi
RESULT[(( ${#RESULT[@]} + 1 ))]="$ARG"; done; echo "${RESULT[@]}"; }

load() { if [[ $# -eq 0 ]]; then local ARGS; read -ra ARGS
  if ${FUNCNAME[0]} "${ARGS[@]}"; then return 0; else return 1; fi; fi
  local ARG; for ARG in "$@"; do source "${QUNITY_DIR}/${ARG//":"/"/"}.sh"
done; }

?() { eval "$*"; }; execute() { local ARGS=( "$@" ) EXEC=( "$*" ) CALL
  if ! load "command:${ARGS[0]-}" 2> /dev/null; then EXEC=( "? ${EXEC[*]}" ); fi
  if [[ $# -eq 0 ]] || arg:has "-h:--help" "${ARGS[@]}"; then echo -e "${HELP[@]}"; return 0; fi
  for CALL in "${EXEC[@]}"; do $CALL; done
}

HELP="$(color 32 "Qunity ${VERSION}")\n
$(color 33 "Usage:")\n    command [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
$(color 33 "Commands:")\n$(commands "./")"

execute "$@"
