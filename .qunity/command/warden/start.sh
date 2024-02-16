#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="start"
DESK="Start Warden environment"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    warden:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

warden:start() {
  if [[ ! -f "/home/$(whoami)/.warden/ssl/certs/${TRAEFIK_DOMAIN}.crt.pem" ]]; then
    print "$(color 32  "Start creating certificate for Warden project")"
    if ! warden sign-certificate "$TRAEFIK_DOMAIN"; then
      print "$(color 31 "Failed to create certificate for Warden project")"; return 1
    fi
  fi

  print "$(color 32 "Start Warden environment")"
  if ! warden env up; then
    print "$(color 31 "Failed to start Warden environment")"; return 1
  fi

  print "$(color 32 "Starting Warden environment successful complete")"
}
