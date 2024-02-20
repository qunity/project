#!/usr/bin/env bash

variable:value() {
  if [[ $# -eq 0 ]]; then local ARGS; read -ra ARGS
    if ${FUNCNAME[0]} "${ARGS[@]}"; then return 0; fi; return 1
  fi

  local RESULT=() ARG; for ARG in "$@"; do
    RESULT[(( ${#RESULT[@]} + 1 ))]="$(eval "echo -n \"\${${ARG}}\"")"
  done

  echo "${RESULT[@]}"
}
