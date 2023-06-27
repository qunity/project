#!/usr/bin/env bash

# Display description
function description() {
  echo "Downloads repositories from list repositories file"
}

# Display help information
function help() {
  echo -e "$(color 32 "$(description)")

$(color 33 "Usage:")
    command [options]

$(color 33 "Options:")
    -h, --help\t\t- Display this help menu
    -f, --force\t\t- Forced download of repositories
\t\t\t  WARNING: Will delete all previously unsaved data"
}

# Execute command
function execute() {
  while IFS=' ' read -r REPOSITORY RELATIVEPATH; do
    if [[ -z "$REPOSITORY" || -z "$RELATIVEPATH" ]]; then continue; fi

    local REPLACE_DIR
    REPLACE_DIR="$(realpath --canonicalize-missing "${QUNITY_DIR}/replace/${RELATIVEPATH}")"

    local DESTINATION_DIR
    DESTINATION_DIR="$(realpath --canonicalize-missing "${BASE_DIR}/${RELATIVEPATH}")"

    if [[ "${1-}" == '-f' || "${1-}" == '--force' ]]; then rm -rf "$DESTINATION_DIR"; fi

    git clone --single-branch "$REPOSITORY" "$DESTINATION_DIR"
    if [[ -d "$REPLACE_DIR" ]]; then cp -r "$REPLACE_DIR" "$(dirname "$DESTINATION_DIR")"; fi
  done < "${QUNITY_DIR}/repositories"
}
