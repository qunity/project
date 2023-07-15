#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="install"
DESK="Install Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    magento:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

magento:install() {
  print "$(color 32  "Start installation Composer packages")"
  if ! warden:exec composer install; then
    print "$(color 31 "Failed to install Composer packages")"; return 1
  fi

  print "$(color 32 "Start installation Magento website")"
  if ! warden:exec magento setup:install; then
    print "$(color 31 "Failed to install Magento website")"; return 1
  fi

  print "$(color 32 "Magento website installation successful complete")"
}
