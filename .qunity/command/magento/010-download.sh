#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:download

NAME="magento:download"
DESK="Download Magento website repository"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-f, --force" "- Force repository download")
$(help:string "" "  WARNING: All local changes will be permanently lost")"

magento:download() {
  if ! download "$MAGENTO_REPOSITORY" "$WARDEN_WEB_ROOT" "$@"; then return 1; fi
}
