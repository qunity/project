#!/usr/bin/env bash

warden:exec() {
  local ARGS=( "$@" )

  case "${ARGS[0]}" in
    magento) ARGS[0]="/var/www/html/bin/magento" ;;
    pwa) ARGS[0]="" ;; # TODO: make a command in /var/www/pwa via yarn
  esac

  if warden env exec php-fpm "${ARGS[@]}"; then return 0; else return 1; fi
}
