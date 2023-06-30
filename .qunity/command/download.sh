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
  echo -e "$(color 32 "Command '$(name)'")
$(description)

$(color 33 "Usage:")
    command [options]

$(color 33 "Options:")
    -h, --help\t\t- Display this help menu
    -f, --force\t\t- Forced download of repositories
\t\t\t  WARNING: Will delete all previously unsaved data"
}

# Execute command
function download() {
  if [[ "${1-}" == '-f' || "${1-}" == '--force' ]]; then
    echo -e "WARNING: Existing project directories will be removed.\n" \
      "\t Are you sure you want to continue in forced mode?"

    select ANSWER in 'Yes' 'No'; do
      case "$ANSWER" in
        Yes) break ;; No) error "Execution aborted by user"; return 1 ;;
      esac
    done
  fi

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
