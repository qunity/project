#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:reindex"
DESK="Reindex Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(color 33 "Arguments:")\n$(help:string "-i, --indexes ..." "- Indexes of Magento website")"

magento:reindex() {
  local INDEXES=(); mapfile -t -d ' ' INDEXES < \
    <(if arg:has "-i:--indexes" "$@"; then arg:get "-i:--indexes" "$@"; fi)

  print "$(color 32 "Reindex Magento website")"
  if ! warden:exec magento indexer:reindex "${INDEXES[@]%%[[:space:]]}"; then
    print "$(color 31 "Failed to reindex Magento website")"; return 1
  fi

  print "$(color 32 "Reindex Magento website successful complete")"
}
