#!/usr/bin/env bash

set -o nounset
set -o errexit

readonly SCRIPT_VERSION="v0.1.0-dev"

readonly BASE_DIR="$(realpath "$(dirname "$0")")"
readonly QUNITY_DIR="${BASE_DIR}/.qunity"

source "${BASE_DIR}/.env"

# Change first letter to upper
function ucfirst() {
  echo -n "${1:0:1}" | tr '[:lower:]' '[:upper:]'; echo "${1:1}"
}

# Wrap string to color
function color() {
  echo "\033[${1}m${2}\033[0m"
}

# Print script message
function print() {
  echo -e "$(date +'%T') $(color "${2-0}" "$(ucfirst "$1")")"
}

# Save failure message of result
function error() {
  export RESULT_MESSAGE="ERROR: ${1}"; return 1
}

# Save information message of result
function info() {
  export RESULT_MESSAGE="INFO: ${1}"; return 0
}

# Display main help
function help() {
  echo -e "$(color 32 "Qunity ${SCRIPT_VERSION}")

$(color 33 "Usage:")
    command [options] [arguments]

$(color 33 "Options:")
    -h, --help\t\t- Display this help menu

$(color 33 "Commands:")
    $(while IFS=' ' read -r COMMAND_FILE; do
      local COMMAND="${COMMAND_FILE%".sh"}"
      local COMMAND_FILE="${QUNITY_DIR}/command/${COMMAND_FILE}"

      # shellcheck source=/.qunity/command/*.sh
      source "$COMMAND_FILE"; echo -e "    ${COMMAND}\t\t- $(description)"
    done < <(ls "${QUNITY_DIR}/command"))"
}

# Execute callback function
function execute() {
  "${@}"
}

# Start script executing
function start() {
  local COMMAND=( "$@" ) START_MESSAGE=( "$@" )
  local COMMAND_FILE="${QUNITY_DIR}/command/${COMMAND[0]-"unexist"}.sh"

  # shellcheck source=/.qunity/command/*.sh
  if [[ -f "$COMMAND_FILE" ]]; then source "$COMMAND_FILE"; unset 'COMMAND[0]'; fi

  local FUNCTION=execute; for PARAMETER in "${COMMAND[@]}"; do
    if [[ "$PARAMETER" == '-h' || "$PARAMETER" == '--help' ]]; then FUNCTION=help; break; fi
  done

  if [[ $# -eq 0 || "$FUNCTION" == help ]]; then help; return 0; fi

  print "INFO: Start '${START_MESSAGE[*]}'" 32; if execute "${COMMAND[@]}"
    then print "${RESULT_MESSAGE="INFO: Success"}" 32
    else print "${RESULT_MESSAGE="ERROR: Unknown error"}" 31
  fi
}

start "${@:1}"
