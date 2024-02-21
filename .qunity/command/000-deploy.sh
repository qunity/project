#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="deploy"
DESK="Deploy project for development"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

EXEC=(
  "execute warden:up"
  "execute magento:download --force"
  "execute magento:install"
  "execute admin:create"
)
