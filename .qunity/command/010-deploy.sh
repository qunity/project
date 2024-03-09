#!/usr/bin/env bash
# shellcheck disable=SC2034

load helper:magento:urn-generate

NAME="deploy"
DESK="Deploy project for development"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")"

EXEC=( "execute warden:down --remove" "execute magento:download --force" "execute warden:up"
"execute magento:install" "execute magento:admin:create" "execute magento:reindex" "execute magento:cache"
"magento:urn-generate" "deploy:completion")

deploy:completion() {
  mkdir -p "${BASE_DIR}/${WARDEN_WEB_ROOT}/app/code/Magento" \
    "${BASE_DIR}/${WARDEN_WEB_ROOT}/lib/internal/Magento/Framework" \
    "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/tests/static/framework/Magento/Sniffs" \
    "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/tools/Magento/Tools" \
    "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/build/publication/sanity/Magento/Tools/Sanity"
}
