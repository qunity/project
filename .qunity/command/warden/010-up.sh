#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="warden:up"
DESK="Run Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

warden:up() {
  if [[ ! -f "/home/$(whoami)/.warden/ssl/certs/${TRAEFIK_DOMAIN}.crt.pem" ]]; then
    print "$(color 32  "Create certificate for Warden project")"
    if ! warden sign-certificate "$TRAEFIK_DOMAIN"; then
      print "$(color 31 "Failed to create certificate for Warden project")"; return 1
    fi
  fi

  print "$(color 32 "Run Warden environment")"
  if ! warden env up; then
    print "$(color 31 "Failed to run Warden environment")"; return 1
  fi

  local WARDEN_READY; for (( i = 60; i > 0; i = i - 10 )); do
    if ! warden:exec composer --version >> /dev/null; then sleep 10; continue; fi;
    WARDEN_READY="true"; break;
  done

  if [[ -z "${WARDEN_READY-}" ]]; then
    print "$(color 31 "Failed to run Warden environment")"; return 1
  fi

  print "$(color 32 "Run Warden environment successful complete")"
}
