#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:variable:list library:variable:value
load helper:download

NAME="download"
DESK="Download project package(s)"

HELP="$(color 32 "$DESK")\n
$(color 33 "Usage:")\n    package:${NAME} [options] [arguments]\n
$(color 33 "Options:")\n    -h, --help\t\t - Display this help menu\n
    -f, --force\t\t - Forced download of repository
\t\t\t   WARNING: It will delete all previously unsaved data
$(color 33 "Arguments:")\n    -p, --package ...\t - Package(s) identity of project"

package:download() { # TODO: add installation of MAGENTO_PWA_* packages
  local IDENTITIES ID VARNAME;

  mapfile -t -d ' ' IDENTITIES < <(
    if arg:has "-p:--package" "$@"; then arg:get "-p:--package" "$@"
    else variable:list "MAGENTO_PKG_*_IDENTITY" | variable:value; fi
  )

  if [[ ${#IDENTITIES[@]} -eq 0 ]]; then
    print "$(color 32 "Package repositories not listed for download")"; return 0
  fi

  for ID in "${IDENTITIES[@]}"; do
    ID="${ID%%[[:space:]]}"; VARNAME="$(echo -n "${ID//[:-]/"_"}" | tr '[:lower:]' '[:upper:]')"
    local SUFFIXES="_${VARNAME}_REPOSITORY"

    if ! read -r REPOSITORY < \
        <((variable:list "MAGENTO_PKG*${SUFFIXES}" | variable:value) 2> /dev/null); then
      print "$(color 31 "Failed to get repository download configuration:") ${NAME}"; return 1
    fi

    local REPOSITORY_DIR; REPOSITORY_DIR="$(echo -n "$REPOSITORY" | grep -o -P '[\w-]+\/[\w-]+')"
    if ! download "$REPOSITORY" "${WARDEN_PKG_ROOT}/${REPOSITORY_DIR}" "$@"; then return 1; fi
  done
}
