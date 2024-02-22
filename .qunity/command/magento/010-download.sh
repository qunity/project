#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:download

NAME="magento:download"
DESK="Download repository of Magento website"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-f, --force" "- Forced download of repository")
$(help:string "" "  WARNING: It will delete all previously unsaved data")"

magento:download() {
  if ! download "$MAGENTO_REPOSITORY" "$WARDEN_WEB_ROOT" "$@"; then return 1; fi
}
