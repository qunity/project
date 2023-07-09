#!/usr/bin/env bash

load library:question:yesno

download() {
  local REPOSITORY="$1"
  local REPLACE_DIR; REPLACE_DIR="$(realpath --canonicalize-missing "${QUNITY_DIR}/replace/${2}")"
  local DESTINATION_DIR; DESTINATION_DIR="$(realpath --canonicalize-missing "${BASE_DIR}/${3}")"

  print "$(color 32 "Downloading repository:") ${REPOSITORY}"

  if [[ -d "$DESTINATION_DIR" ]] && ! option "-f:--force" "$@"; then
    echo -e "$(color 33 "WARNING:") Existing project directories will be removed."

    if ! question:yesno "Are you sure you want to continue?"; then
      result "Execution aborted"; return 0
    elif ! rm -rf "$DESTINATION_DIR"; then
      result "Failed to remove directory: $(color 0 "$DESTINATION_DIR")"; return 1
    fi
  fi

  if ! git clone --single-branch "$REPOSITORY" "$DESTINATION_DIR"; then
    result "Failed to clone repository:" \
      "$(color 0 "${REPOSITORY} > ${DESTINATION_DIR}")"; return 1
  fi

  if [[ -d "$REPLACE_DIR" ]] && ! cp -r "$REPLACE_DIR" "$(dirname "$DESTINATION_DIR")"; then
    result "Failed to copy replacing directory:" \
      "$(color 0 "${REPLACE_DIR} > ${DESTINATION_DIR}")"; return 1
  fi

  result "Downloading successful: $(color 0 "${REPOSITORY} > ${DESTINATION_DIR}")"
}
