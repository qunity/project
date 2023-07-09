#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:download

NAME="magento:download"
DESK="Download Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    command [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data"

magento:download() {
  download "$MAGENTO_REPOSITORY" "$MAGENTO_REPLACE_DIR" "$MAGENTO_DESTINATION_DIR" "${ARGS[@]}"
}
