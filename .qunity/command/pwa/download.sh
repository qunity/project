#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:download

NAME="download"
DESK="Download Magento PWA repository"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    pwa:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data"

pwa:download() {
  if ! download "$MAGENTO_PWA_REPOSITORY" "$WARDEN_PWA_ROOT" "$@"; then return 1; fi
}
