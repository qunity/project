#!/usr/bin/env bash

# Display name
function name() {
  echo "download"
}

# Display description
function description() {
  echo "Project repositories downloads"
}

# Display help information
function help() {
  echo -e "$(color 32 "$(description)")

$(color 33 "Usage:")
    command [options]

$(color 33 "Options:")
    -h, --help\t\t- Display this help menu
    -f, --force\t\t- Forced download of repositories
\t\t\t  WARNING: It will delete all previously unsaved data"
}

# Execute command
function download() {
  if [[ "${1-}" == '-f' || "${1-}" == '--force' ]]; then
    echo -e "$(color 33 "WARNING:") Existing project directories will be removed.
Are you sure you want to continue in forced mode?"

    select ANSWER in 'Yes' 'No'; do
      case "$ANSWER" in
        Yes) break ;; No) info "Execution aborted"; return 0 ;;
      esac
    done
  fi

  while IFS=' ' read -r REPOSITORY RELATIVEPATH; do
    if [[ -z "$REPOSITORY" || -z "$RELATIVEPATH" ]]; then continue; fi

    local REPLACE_DIR
    REPLACE_DIR="$(realpath --canonicalize-missing "${QUNITY_DIR}/replace/${RELATIVEPATH}")"

    local DESTINATION_DIR
    DESTINATION_DIR="$(realpath --canonicalize-missing "${BASE_DIR}/${RELATIVEPATH}")"

    if [[ "${1-}" == '-f' || "${1-}" == '--force' ]]; then
      if ! rm -rf "$DESTINATION_DIR"; then
        error "Failed to remove directory: $(color 0 "$DESTINATION_DIR")"; return 1
      fi
    fi

    if ! git clone --single-branch "$REPOSITORY" "$DESTINATION_DIR"; then
      error "Failed to clone repository:" \
        "$(color 0 "${REPOSITORY} > ${DESTINATION_DIR}")"; return 1
    fi

    if [[ -d "$REPLACE_DIR" ]]; then
      if ! cp -r "$REPLACE_DIR" "$(dirname "$DESTINATION_DIR")"; then
        error "Failed to copy replacing directory:" \
          "$(color 0 "${REPLACE_DIR} > ${DESTINATION_DIR}")"; return 1
      fi
    fi
  done < "${QUNITY_DIR}/repositories"
}
