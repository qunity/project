#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="stop"
DESK="Stop Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    warden:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

warden:stop() {
  print "$(color 32 "Stop Warden environment")"
  if ! warden env down; then
    print "$(color 31 "Failed to stop Warden environment")"; return 1
  fi

  print "$(color 32 "Stopping Warden environment successful complete")"
}
