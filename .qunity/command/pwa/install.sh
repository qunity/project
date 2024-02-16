#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="install"
DESK="Install Magento PWA"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    pwa:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

pwa:install() {
  print "$(color 32  "Start installation Node packages")"
  if ! warden:exec yarn install; then
    print "$(color 31 "Failed to install Node packages")"; return 1
  fi

  print "$(color 32 "Start building Magento PWA")"
  if ! warden:exec pwa build; then
    print "$(color 31 "Failed to build Magento PWA")"; return 1
  fi

  print "$(color 32 "Installation Magento PWA successful complete")"
}
