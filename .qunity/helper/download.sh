#!/usr/bin/env bash

load library:question:yesno

download() {
  local REPOSITORY="$1"
  local REPLACE_DIR; REPLACE_DIR="$(realpath --canonicalize-missing "${QUNITY_DIR}/replace/${2}")"
  local DESTINATION_DIR; DESTINATION_DIR="$(realpath --canonicalize-missing "${BASE_DIR}/${3}")"

  print "$(color 32 "Downloading repository:") ${REPOSITORY}"

  if [[ -d "$DESTINATION_DIR" ]] && arg:has "-f:--force" "$@"; then
    print "$(color 33 "WARNING:") Directory will be removed: ${DESTINATION_DIR}"

    if ! question:yesno "Are you sure you want to continue?"; then
      print "$(color 32 "Execution aborted")"; return 0
    fi

    if ! rm -rf "$DESTINATION_DIR"; then
      print "$(color 31 "Failed to remove directory:") $(color 0 "$DESTINATION_DIR")"; return 1
    fi
  fi

  if ! git clone --single-branch "$REPOSITORY" "$DESTINATION_DIR"; then
    print "$(color 31 "Failed to clone repository:")" \
      "$(color 0 "${REPOSITORY} > ${DESTINATION_DIR}")"; return 1
  fi

  if [[ -d "$REPLACE_DIR" ]] && ! cp -r "$REPLACE_DIR" "$(dirname "$DESTINATION_DIR")"; then
    print "$(color 31 "Failed to copy replacing directory:")" \
      "$(color 0 "${REPLACE_DIR} > ${DESTINATION_DIR}")"; return 1
  fi

  print "$(color 32 "Successful complete")"
}
