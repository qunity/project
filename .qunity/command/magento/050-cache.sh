#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:cache"
DESK="Flush cache Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(color 33 "Arguments:")\n$(help:string "-c, --caches ..." "- Caches of Magento website")"

magento:cache() {
  local CACHES=(); mapfile -t -d ' ' CACHES < \
    <(if arg:has "-c:--caches" "$@"; then arg:get "-c:--caches" "$@"; fi)

  print "$(color 32 "Flush cache Magento website")"
  if ! warden:exec magento cache:flush "${CACHES[@]%%[[:space:]]}"; then
    print "$(color 31 "Failed to flush cache Magento website")"; return 1
  fi

  print "$(color 32 "Flush cache Magento website successful complete")"
}
