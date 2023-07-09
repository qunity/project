#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:download

NAME="pwa:download"
DESK="Download Magento PWA"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    command [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data"

pwa:download() {
  download "$PWA_REPOSITORY" "$PWA_REPLACE_DIR" "$PWA_DESTINATION_DIR" "${ARGS[@]}"
}
