#!/usr/bin/env bash

# Display name
function name() {
  echo "install"
}

# Display description
function description() {
  echo "Magento 2 website installation"
}

# Display help information
function help() {
  echo -e "$(color 32 "Command '$(name)'")
$(description)

$(color 33 "Usage:")
    command [options]

$(color 33 "Options:")
    --no-dev\t\t- Disables installation of require-dev packages
    -o, --optimize-autoloader\t\t- Optimize autoloader during autoloader dump"
}

# Execute command
function install() {
  readonly PHP="/usr/bin/php"
  readonly COMPOSER="/usr/bin/composer"
  readonly MAGENTO="${BASE_DIR}/bin/magento"

  print "Start install Composer packages" 31
  if ! "$COMPOSER" install "$@"; then
    error "Failed to install Composer packages"; return 1
  fi

  print "Start install Magento 2 application" 31
  if ! "$PHP" "$MAGENTO" setup:install; then
    error "Failed to install Magento 2 application"; return 1
  fi

  info "Magento 2 website installation completed"
}
