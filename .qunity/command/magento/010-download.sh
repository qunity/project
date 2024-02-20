#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:download

NAME="magento:download"
DESK="Download repository of Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-f, --force" "- Forced download of repository")
$(help:string "" "  WARNING: It will delete all previously unsaved data")"

magento:download() {
  if ! download "$MAGENTO_REPOSITORY" "$WARDEN_WEB_ROOT" "$@"; then return 1; fi
}
