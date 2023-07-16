#!/usr/bin/env bash

warden:exec() {
  local ARGS=( "$@" )

  case "${ARGS[0]}" in
    php) ARGS=( "php-fpm" "/usr/bin/php" "${ARGS[@]:1}" ) ;;
    composer) ARGS=( "php-fpm" "/usr/bin/composer" "${ARGS[@]:1}" ) ;;
    magento) ARGS=( "php-fpm" "/var/www/html/bin/magento" "${ARGS[@]:1}" ) ;;
    pwa|yarn) ;; # TODO: make a command in /var/www/pwa via yarn
  esac

  if warden env exec "${ARGS[@]}"; then return 0; else return 1; fi
}
