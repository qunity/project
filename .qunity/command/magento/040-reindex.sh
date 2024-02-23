#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:reindex"
DESK="Reindex Magento website"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options] [arguments]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(style 33 "Arguments:")\n$(help:string "-i, --index ..." "- Index list of Magento website")"

magento:reindex() {
  local INDEXES=(); mapfile -t -d ' ' INDEXES < \
    <(if arg:has "-i:--index" "$@"; then arg:get "-i:--index" "$@"; fi)

  print "$(style 32 "Reindex Magento website")"
  if ! warden:exec magento indexer:reindex "${INDEXES[@]%%[[:space:]]}"; then
    print "$(style 31 "Failed to reindex Magento website")"; return 1
  fi

  print "$(style 32 "Reindex Magento website successful complete")"
}
