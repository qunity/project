#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:question:yesno

NAME="warden:down"
DESK="Stop Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-v, --volumes" "- Stop and remove project volumes")
$(help:string "" "  WARNING: It will remove all project Compose volumes")"

warden:down() {
  local ARGS=();

  print "$(color 32 "Stop Warden environment")"

  if arg:has "-v:--volumes" "$@"; then
    print "$(color 33 "WARNING:") All project Compose volumes will be removed"

    if ! question:yesno "Are you sure you want to continue?"; then
      print "$(color 32 "Execution aborted")"; return 0
    fi

    ARGS[0]="--volumes"
  fi

  if ! warden env down "${ARGS[@]}"; then
    print "$(color 31 "Failed to stop Warden environment")"; return 1
  fi

  print "$(color 32 "Stop Warden environment successful complete")"
}
