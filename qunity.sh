#!/usr/bin/env bash
# shellcheck source=./.qunity/[*/]*.sh; disable=SC2034,SC2016

set -o nounset -o errexit

readonly VERSION="v1.0.2-dev"
readonly BASE_DIR="$(realpath "$(dirname "$0")")"
readonly QUNITY_DIR="${BASE_DIR}/.qunity"

if [[ -f "${BASE_DIR}/.env" ]]; then source "${BASE_DIR}/.env"; fi
if [[ -f "${QUNITY_DIR}/.env" ]]; then source "${QUNITY_DIR}/.env"; fi

color() { echo "\033[${1}m${*:2}\033[0m"; }; print() { echo -e "$(date +'%T') ${*}"; }
result() { RESULT="$*"; }; ?() { eval "$@"; }

commands() { local FILE; while read -r FILE; do
  source "$FILE"; printf "%${2-4}s${NAME-"..."}%$(( ${3-19} * -1 ))s - ${DESK-"..."}\n"
done < <(ls "${QUNITY_DIR}/command/${1//":"/"/"}"/*.sh 2> /dev/null); }

option() { local ARG; for ARG in "${@:2}"; do
  if [[ "$ARG" == "${1%%":"*}" || "$ARG" == "${1##*":"}" ]]; then return 0; fi
done; return 1; }

load() { if [[ $# -eq 0 ]]; then local NAMES; read -ra NAMES; ${FUNCNAME[0]} "${NAMES[@]}"; fi
  local NAME; for NAME in "$@"; do if [[ -n "$NAME" ]]; then
source "${QUNITY_DIR}/${NAME//":"/"/"}.sh"; fi; done; }

execute() { local ARGS=( "$@" ) EXEC=( "$*" ) CALL TEMPLATE='if ! eval "@call"; then
  print "$(color 31 "${RESULT-"Runtime error"}")"; return 1; fi'

  if ! load "command:${EXEC[0]-}" 2> /dev/null; then EXEC=( "?" "${EXEC[@]}" ); fi

  if option "-h:--help" "${EXEC[@]}"; then EXEC[0]+="@help"; fi
  if [[ $# -eq 0 || "${EXEC[0]}" == *"@help" ]]; then echo -e "${HELP[@]}"; return 0; fi

  if [[ "${EXEC[0]}" == "@replace" ]]; then unset "EXEC[0]"; TEMPLATE="@call"; fi

  print "$(color 32 "Execution:") ${0} ${ARGS[*]}"
  for CALL in "${EXEC[@]}"; do eval "${TEMPLATE/"@call"/"${CALL[@]}"}"; done
}

HELP="$(color 32 "Qunity ${VERSION}")\n
$(color 33 "Usage:")\n    command [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
$(color 33 "Commands:")\n$(commands "./")"

execute "$@"
