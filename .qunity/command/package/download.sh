#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:variable:list library:variable:value
load helper:download

NAME="download"
DESK="Download Magento package(s)"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    package:${NAME} [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data
$(color 33 "Arguments:")\n    -p, --packages ...\t - Package(s) name of Magento website"

package:download() {
  local NAMES NAME VARNAME;

  mapfile -t -d ' ' NAMES < <(
    if arg:has "-p:--packages" "$@"; then arg:get "-p:--packages" "$@"
    else variable:list "PKG_*_NAME" | variable:value; fi
  )

  if [[ ${#NAMES[@]} -eq 0 ]]; then
    print "$(color 32 "Package repositories not listed for download")"; return 0
  fi

  for NAME in "${NAMES[@]}"; do
    NAME="${NAME%%[[:space:]]}"
    VARNAME="$(echo -n "${NAME//[:-]/"_"}" | tr '[:lower:]' '[:upper:]')"

    local SUFFIXES="_${VARNAME}_REPOSITORY:_${VARNAME}_REPLACE_DIR:_${VARNAME}_DESTINATION_DIR"

    if ! read -r REPOSITORY REPLACE_DIR DESTINATION_DIR < \
        <((variable:list "PKG_*${SUFFIXES}" | variable:value) 2> /dev/null); then
      print "$(color 31 "Failed to get repository download configuration:") ${NAME}"; return 1
    fi

    if ! download "$REPOSITORY" "$REPLACE_DIR" "$DESTINATION_DIR" "$@"; then return 1; fi
  done
}
