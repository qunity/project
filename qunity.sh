#!/usr/bin/env bash

set -o nounset
set -o errexit

readonly BASE_DIR="$(realpath "$(dirname "$0")")"
source "${BASE_DIR}/.env"

# Change first letter to upper
function ucfirst() {
  echo -n "${1:0:1}" | tr '[:lower:]' '[:upper:]'; echo "${1:1}"
}

# Success message
function print() {
  echo -e "$(date +'%T') \033[32m> $(ucfirst "$1")\033[0m"; return 0
}

# Failure message
function error() {
  echo -e "$(date +'%T') \033[31m> $(ucfirst "$1")\033[0m"; return 1
}

# Execute callback function
function call() {
  if "${@: 1:$#-2}"; then print "${@: -2:1}"; else error "${@: -1:1}"; fi
}

print "Start $([ -n "${*:1}" ] && echo "'${*:1}'" || echo "")"

case "${1-}" in
  *) call "${@:1}" "Success" "Runtime error" ;;
esac
