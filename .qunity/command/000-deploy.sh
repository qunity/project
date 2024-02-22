#!/usr/bin/env bash
# shellcheck disable=SC2034

NAME="deploy"
DESK="Deploy project for development"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

EXEC=( "execute warden:down --remove" "execute magento:download --force" "execute warden:up"
"execute magento:install" "execute magento:admin:create" "execute magento:reindex" "execute magento:cache" )
