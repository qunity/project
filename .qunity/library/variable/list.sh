#!/usr/bin/env bash

variable:list() {
  if [[ $# -eq 0 ]]; then
    local ARGS; read -ra ARGS
    if ${FUNCNAME[0]} "${ARGS[@]}"; then return 0; else return 1; fi
  fi

  local RESULT=() ARG
  for ARG in "$@"; do
    local PREFIX="${ARG%%"*"*}" SUFFIXES="${ARG##*"*"}" NAMES NAME

    mapfile -t -d ' ' NAMES < <(eval "echo -n \"\${!${PREFIX}*}\"")
    mapfile -t -d ':' SUFFIXES < <(echo -n "$SUFFIXES")

    if [[ ${#SUFFIXES[@]} -eq 0 ]]; then SUFFIXES=( "" ); fi

    for SUFFIX in "${SUFFIXES[@]}"; do for NAME in "${NAMES[@]}"; do
      if [[ "$NAME" == *"${SUFFIX}" ]]; then RESULT[(( ${#RESULT[@]} + 1 ))]="$NAME"; fi
    done; done
  done

  echo "${RESULT[@]}"
}
