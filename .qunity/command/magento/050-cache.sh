#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:cache"
DESK="Flush Magento website cache"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options] [arguments]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(style 33 "Arguments:")\n$(help:string "-c, --cache ..." "- Magento website cache list")"

magento:cache() {
  local CACHES=(); IFS=' ' read -ra CACHES <<< \
    "$(if arg:has "-c:--cache" "$@"; then arg:get "-c:--cache" "$@"; fi)"

  print "$(style 32 "Flush Magento website cache")"
  if ! warden:exec magento cache:flush "${CACHES[@]%%[[:space:]]}"; then
    print "$(style 31 "Failed to flush Magento website cache")"; return 1
  fi

  print "$(style 32 "Magento website cache flushed successfully")"
}
