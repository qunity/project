#!/usr/bin/env bash

warden:exec() {
  local ARGS=( "$@" )

  case "${ARGS[0]}" in
    magento) ARGS[0]="cd /var/www/html; bin/magento" ;;
    pwa) ARGS[0]="cd /var/www/pwa; yarn" ;;
  esac

  if warden env exec php-fpm "${ARGS[@]}"; then return 0; else return 1; fi
}
