#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:warden:exec

NAME="magento:install"
DESK="Install Magento website"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

magento:install() {
  print "$(style 32  "Install Composer packages")"
  if ! warden:exec composer install; then
    print "$(style 31 "Failed to install Composer packages")"; return 1
  fi

  print "$(style 32 "Install Magento website")"
  if ! warden:exec magento setup:install; then
    print "$(style 31 "Failed to install Magento website")"; return 1
  fi

  print "$(style 32 "Installation Magento website successful complete")"
}
