#!/usr/bin/env bash

variable:list() {
  if [[ $# -eq 0 ]]; then local ARGS; read -ra ARGS
    if ${FUNCNAME[0]} "${ARGS[@]}"; then return 0; fi; return 1
  fi

  local RESULT=() ARG; for ARG in "$@"; do
    local PREFIX="${ARG%%\**}" SUFFIXES="${ARG##*\*}" SUFFIX NAMES NAME

    IFS=' ' read -ra NAMES <<< "$(eval "printf '%s' \"\${!${PREFIX}*}\"")"
    IFS=':' read -ra SUFFIXES <<< "$SUFFIXES"

    if [[ ${#SUFFIXES[@]} -eq 0 ]]; then SUFFIXES=( "" ); fi

    for SUFFIX in "${SUFFIXES[@]}"; do for NAME in "${NAMES[@]}"; do
      if [[ "$NAME" == *"${SUFFIX}" ]]; then RESULT[${#RESULT[@]} + 1]="$NAME"; fi
    done; done
  done

  echo "${RESULT[@]}"
}
