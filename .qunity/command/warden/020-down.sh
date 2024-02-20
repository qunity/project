#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="warden:down"
DESK="Stop Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

warden:down() {
  print "$(color 32 "Stop Warden environment")"
  if ! warden env down; then
    print "$(color 31 "Failed to stop Warden environment")"; return 1
  fi

  print "$(color 32 "Stop Warden environment successful complete")"
}
