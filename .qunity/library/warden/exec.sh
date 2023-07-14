#!/usr/bin/env bash

warden:exec() {
  if warden env exec php-fpm "$@"; then return 0; else return 1; fi
}
