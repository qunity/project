#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="warden:up"
DESK="Run Warden environment"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

warden:up() {
  local WARDEN_CERTS_DIR; WARDEN_CERTS_DIR="/home/$(whoami)/.warden/ssl/certs"

  if [[ ! -f "${WARDEN_CERTS_DIR}/${TRAEFIK_DOMAIN}.crt.pem" ||
        ! -f "${WARDEN_CERTS_DIR}/${TRAEFIK_DOMAIN}.csr.pem" ||
        ! -f "${WARDEN_CERTS_DIR}/${TRAEFIK_DOMAIN}.key.pem" ]]
  then
    print "$(style 32  "Create certificates for Warden project")"

    if ! warden sign-certificate "$TRAEFIK_DOMAIN"; then
      print "$(style 31 "Failed to create certificates for Warden project")"; return 1
    fi
  fi

  print "$(style 32 "Run Warden environment")"
  if ! warden env up; then
    print "$(style 31 "Failed to run Warden environment")"; return 1
  fi

  local WARDEN_READY; for (( i = 60; i >= 0; i -= 10 )); do
    if ! execute warden:status; then sleep 10; continue; fi;
    WARDEN_READY="true"; break;
  done

  if [[ -z "${WARDEN_READY-}" ]]; then
    print "$(style 31 "Failed to run Warden environment")"; return 1
  fi

  print "$(style 32 "Run Warden environment successful complete")"
}
