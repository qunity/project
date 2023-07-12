#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="install"
DESK="Install Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    magento:${NAME} [options]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu"

magento:install() {
  readonly PHP="/usr/bin/php"
  readonly COMPOSER="/usr/bin/composer"
  readonly MAGENTO="${BASE_DIR}/bin/magento"

  print "$(color 32  "Start installation Composer packages")"
  if ! $COMPOSER install; then
    print "$(color 31 "Failed to install Composer packages")"; return 1
  fi

  print "$(color 32 "Start installation Magento website")"
  if ! $PHP "$MAGENTO" setup:install; then
    print "$(color 31 "Failed to install Magento website")"; return 1
  fi

  print "$(color 32 "Magento website installation successful complete")"
}
