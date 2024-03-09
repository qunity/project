#!/usr/bin/env bash

magento:create-directories() {
  if ! mkdir -p "${BASE_DIR}/${WARDEN_WEB_ROOT}/app/code/Magento" \
        "${BASE_DIR}/${WARDEN_WEB_ROOT}/lib/internal/Magento/Framework" \
        "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/tests/static/framework/Magento/Sniffs" \
        "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/tools/Magento/Tools" \
        "${BASE_DIR}/${WARDEN_WEB_ROOT}/dev/build/publication/sanity/Magento/Tools/Sanity"
  then
      print "$(style 31 "Failed to create Magento directories for development")"; return 1
  fi
}
