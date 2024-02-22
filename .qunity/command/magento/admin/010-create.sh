#!/usr/bin/env bash
# shellcheck disable=SC2034

load library:variable:list library:variable:value
load library:warden:exec

NAME="magento:admin:create"
DESK="Create admins of Magento website"

HELP="$(style 32 "$DESK")\n
$(style 33 "Usage:")\n$(help:string "${SCRIPT} ${NAME} [options] [arguments]")\n
$(style 33 "Options:")\n$(help:string "-h, --help" "- Display this help menu")\n
$(style 33 "Arguments:")\n$(help:string "-a, --admin ..." "- Admins identity of Magento website")"

magento:admin:create() {
  local IDENTITIES ID VARNAME;

  mapfile -t -d ' ' IDENTITIES < <(
    if arg:has "-a:--admin" "$@"; then arg:get "-a:--admin" "${@//\//:}"
    else variable:list "MAGENTO_ADMIN_*_IDENTITY" | variable:value; fi
  )

  if [[ ${#IDENTITIES[@]} -eq 0 ]]; then
    print "$(style 32 "Magento website admins not listed for creating")"; return 0
  fi

  for ID in "${IDENTITIES[@]}"; do
    ID="${ID%%[[:space:]]}"; VARNAME="$(echo -n "${ID//[:-]/_}" | tr '[:lower:]' '[:upper:]')"
    local SUFFIXES="_${VARNAME}_USER:_${VARNAME}_EMAIL:_${VARNAME}_PASSWORD"
    SUFFIXES+=":_${VARNAME}_FIRSTNAME:_${VARNAME}_LASTNAME"

    if ! read -r USER EMAIL PASSWORD FIRSTNAME LASTNAME < \
        <((variable:list "MAGENTO_ADMIN_*${SUFFIXES}" | variable:value) 2> /dev/null); then
      print "$(style 31 "Failed to get admins information configuration:") ${ID}"; return 1
    fi

    if ! warden:exec magento admin:user:create --admin-user "$USER" \
        --admin-email "$EMAIL" --admin-password "$PASSWORD" \
        --admin-firstname "$FIRSTNAME" --admin-lastname "$LASTNAME"; then
      print "$(style 31 "Failed to create Magento website admin")" "${FIRSTNAME} ${LASTNAME}"; return 1
    fi

    if ! warden:exec magento admin:user:unlock "$USER"; then
      print "$(style 31 "Failed to unlock Magento website admin")" "${FIRSTNAME} ${LASTNAME}"; return 1
    fi
  done
}
