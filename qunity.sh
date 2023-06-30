#!/usr/bin/env bash

set -o nounset
set -o errexit

readonly SCRIPT_VERSION="v0.1.3-dev"

readonly BASE_DIR="$(realpath "$(dirname "$0")")"
readonly QUNITY_DIR="${BASE_DIR}/.qunity"
readonly ENV_FILE="${BASE_DIR}/.env"

# shellcheck source=./.env
if [[ -f "$ENV_FILE" ]]; then source "$ENV_FILE"; fi

# Get random string
function random() {
  echo "$RANDOM" | md5sum | head -c 20
}

# Change first letter to upper
function ucfirst() {
  echo -n "${1:0:1}" | tr '[:lower:]' '[:upper:]'; echo "${1:1}"
}

# Wrap string(s) to color
function color() {
  echo "\033[${1}m${*:2}\033[0m"
}

# Print script message
function print() {
  echo -e "$(date +'%T') $(color "${2-0}" "$(ucfirst "$1")")"
}

# Save failure message of result
function error() {
  export RESULT_MESSAGE="ERROR: ${*}"; return 1
}

# Save information message of result
function info() {
  export RESULT_MESSAGE="INFO: ${*}"; return 0
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
  # shellcheck source=./.qunity/command/*.sh
  source "${QUNITY_DIR}/command/${COMMAND_FILE}"

  echo -e "    $(name)\t\t- $(description)"
done < <(ls "${QUNITY_DIR}/command"))"
}

# Execute command
function execute() {
  local COMMAND=( "$@" )
  local COMMAND_FILE="${QUNITY_DIR}/command/${COMMAND[0]-"$(random)"}.sh"

  # shellcheck source=./.qunity/command/*.sh
  if [[ -f "$COMMAND_FILE" ]]; then source "$COMMAND_FILE"; fi

  for PARAMETER in "${COMMAND[@]}"; do
    if [[ "$PARAMETER" == '-h' || "$PARAMETER" == '--help' ]]; then
      COMMAND[0]=help; break
    fi
  done

  if [[ $# -eq 0 || "${COMMAND[0]}" == help ]]; then
    help; return 0
  fi

  print "INFO: Start $(color 0 "\`${COMMAND[*]}\`")" 32;

  if "${COMMAND[@]}"; then
    print "${RESULT_MESSAGE="INFO: Success"}" 32
  else
    print "${RESULT_MESSAGE="ERROR: $(color 0 "\`${COMMAND[*]}\`")"}" 31
  fi
}

execute "${@:1}"
