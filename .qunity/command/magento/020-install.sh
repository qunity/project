#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:install"
DESK="Install Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

magento:install() {
  print "$(color 32  "Install Composer packages")"
  if ! warden:exec composer install; then
    print "$(color 31 "Failed to install Composer packages")"; return 1
  fi

  print "$(color 32 "Install Magento website")"
  if ! warden:exec magento setup:install; then
    print "$(color 31 "Failed to install Magento website")"; return 1
  fi

  print "$(color 32 "Installation Magento website successful complete")"
}
