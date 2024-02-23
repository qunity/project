#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:question:yesno

NAME="warden:down"
DESK="Stop Warden environment"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-r, --remove" "- Stop and remove Warden environment data")
$(help:string "" "  WARNING: It will remove all Compose volumes and certificates")"

warden:down() {
  local ARGS=(); print "$(style 32 "Stop Warden environment")"

  if arg:has "-r:--remove" "$@"; then
    print "$(style 33 "WARNING:") All project Compose volumes will be removed"

    if ! question:yesno "Are you sure you want to continue?"; then
      print "$(style 32 "Execution aborted")"; return 0
    fi

    ARGS[0]="--volumes"
  fi

  if ! warden env down "${ARGS[@]}"; then
    print "$(style 31 "Failed to stop Warden environment")"; return 1
  fi

  if arg:has "-r:--remove" "$@"; then
    local WARDEN_CERT_FILES=( "/home/$(whoami)/.warden/ssl/certs/${TRAEFIK_DOMAIN}".*.pem )

    if [[ ${#WARDEN_CERT_FILES[@]} -gt 1 && "${WARDEN_CERT_FILES[0]}" != *.\*.pem ]]; then
      if ! rm -rf "${WARDEN_CERT_FILES[@]}"; then
        print "$(style 31 "Failed to remove certificates of Warden project")"; return 1
      fi
    fi
  fi

  print "$(style 32 "Stop Warden environment successful complete")"
}
