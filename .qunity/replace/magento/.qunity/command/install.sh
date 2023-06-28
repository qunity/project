#!/usr/bin/env bash

# Display description
function description() {
  echo "Magento 2 website installation"
}

# Display help information
function help() {
  echo -e "$(color 32 "$(description)")

$(color 33 "Usage:")
    command

$(color 33 "Options:")
    none"
}

# Execute command
function install() {
  readonly PHP="/usr/bin/php"
  readonly COMPOSER="/usr/bin/composer"
  readonly MAGENTO="${BASE_DIR}/bin/magento"

  print "Start install Composer packages" 31
  if ! "${COMPOSER}" install; then
    error "Failed to install Composer packages"; return 1
  fi

  print "Start install Magento 2 application" 31
  if ! "${PHP}" "${MAGENTO}" setup:install; then
    error "Failed to install Magento 2 application"; return 1
  fi
}
