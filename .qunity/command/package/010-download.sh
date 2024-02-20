#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:variable:list library:variable:value
load helper:download

NAME="package:download"
DESK="Download package(s) repositories of Magento website"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n$(help:string "command [options] [arguments]")\n
$(color 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(help:string "-f, --force" "- Forced download of repository")
$(help:string "" "  WARNING: It will delete all previously unsaved data")
$(color 33 "Arguments:")\n$(help:string "-p, --package ..." "- Package(s) identity of Magento website")"

package:download() {
  local IDENTITIES ID VARNAME;

  mapfile -t -d ' ' IDENTITIES < <(
    if arg:has "-p:--package" "$@"; then arg:get "-p:--package" "${@//\//:}"
    else variable:list "MAGENTO_PKG_*_IDENTITY" | variable:value; fi
  )

  if [[ ${#IDENTITIES[@]} -eq 0 ]]; then
    print "$(color 32 "Package repositories not listed for download")"; return 0
  fi

  for ID in "${IDENTITIES[@]}"; do
    ID="${ID%%[[:space:]]}"; VARNAME="$(echo -n "${ID//[:-]/_}" | tr '[:lower:]' '[:upper:]')"
    local SUFFIXES="_${VARNAME}_REPOSITORY"

    if ! read -r REPOSITORY < \
        <((variable:list "MAGENTO_PKG*${SUFFIXES}" | variable:value) 2> /dev/null); then
      print "$(color 31 "Failed to get repository download configuration:") ${ID}"; return 1
    fi

    local REPOSITORY_DIR; REPOSITORY_DIR="$(echo -n "$REPOSITORY" | grep -o -P '[\w-]+\/[\w-]+')"
    if ! download "$REPOSITORY" \
      "${WARDEN_WEB_ROOT}/packages/${REPOSITORY_DIR}" "$@"; then return 1; fi
  done
}
