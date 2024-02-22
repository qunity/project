#!/usr/bin/env bash

load library:question:yesno

download() {
  local REPOSITORY="$1"
  local REPOSITORY_DIR; REPOSITORY_DIR="$(echo -n "$REPOSITORY" | grep -o -P '[\w-]+\/[\w-]+')"
  local REPLACE_DIR; REPLACE_DIR="$(realpath -m "${QUNITY_DIR}/replace/${REPOSITORY_DIR}")"
  local DESTINATION_DIR; DESTINATION_DIR="$(realpath --canonicalize-missing "${BASE_DIR}/${2}")"

  print "$(style 32 "Downloading repository:") ${REPOSITORY}"

  if [[ -d "$DESTINATION_DIR" ]] && arg:has "-f:--force" "$@"; then
    print "$(style 33 "WARNING:") Directory will be removed: ${DESTINATION_DIR}"

    if ! question:yesno "Are you sure you want to continue?"; then
      print "$(style 32 "Execution aborted")"; return 0
    fi

    if ! rm -rf "$DESTINATION_DIR"; then
      print "$(style 31 "Failed to remove directory:") ${DESTINATION_DIR}"; return 1
    fi
  fi

  if ! git clone --single-branch "$REPOSITORY" "$DESTINATION_DIR"; then
    print "$(style 31 "Failed to clone repository:") ${REPOSITORY} > ${DESTINATION_DIR}"; return 1
  fi

  if [[ -d "$REPLACE_DIR" ]] && ! cp -r "$REPLACE_DIR" "$(dirname "$DESTINATION_DIR")"; then
    print "$(style 31 "Failed to copy directory:") ${REPLACE_DIR} > ${DESTINATION_DIR}"; return 1
  fi

  print "$(style 32 "Successful complete")"
}
