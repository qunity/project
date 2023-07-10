#!/usr/bin/env bash

variable:value() {
  if [[ $# -eq 0 ]]; then local ARGS; read -ra ARGS; ${FUNCNAME[0]} "${ARGS[@]}"; return 0; fi
  local RESULT=() ARG; for ARG in "$@"; do
    RESULT[(( ${#RESULT[@]} + 1 ))]="$(eval "echo -n \"\${${ARG}}\"")"
  done; echo -n "${RESULT[@]}"
}
