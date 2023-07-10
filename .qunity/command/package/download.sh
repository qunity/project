#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:variable:list library:variable:value helper:download

NAME="package:download"
DESK="Download Magento package(s)"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    command [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data
$(color 33 "Arguments:")\n    -p, --packages [...]\t - Package(s) name of Magento website"

package:download() {
  local NAMES NAME;

  if option "-p:--packages" "$@"; then
    mapfile -t -d ' ' NAMES < <(argument "-p:--packages" "$@")
  else
    mapfile -t -d ' ' NAMES < <(variable:list "PKG_*_NAME" | variable:value)
  fi

  for NAME in "${NAMES[@]}"; do
    NAME="$(echo -n "${NAME//[:-]/"_"}" | tr '[:lower:]' '[:upper:]')"
    local SUFFIXES="_${NAME}_REPOSITORY:_${NAME}_REPLACE_DIR:_${NAME}_DESTINATION_DIR"

    read -r REPOSITORY REPLACE_DIR DESTINATION_DIR < \
      <(variable:list "PKG_*${SUFFIXES}" | variable:value)

    if ! download "$REPOSITORY" "$REPLACE_DIR" "$DESTINATION_DIR" "$@"; then
      return 1
    fi
  done
}
