#!/usr/bin/env bash

load library:warden:exec

magento:urn-generate() {
    if ! warden:exec magento dev:urn-catalog:generate --ide phpstorm misc.xml; then
      print "$(style 31 "Failed to generate Catalog URN list for PhpStorm")"; return 1
    fi

    local MAGENTO_DIR="${BASE_DIR}/${WARDEN_WEB_ROOT}"

    # shellcheck disable=SC2016
    if ! sed -i 's/\$PROJECT_DIR\$/\$PROJECT_DIR\$\/magento/g' "${MAGENTO_DIR}/misc.xml" ||
       ! mv -f "${MAGENTO_DIR}/misc.xml" "${BASE_DIR}/.idea/misc.xml"
    then
      print "$(style 31 "Failed to generate Catalog URN list for PhpStorm")"; return 1
    fi
}
