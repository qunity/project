#!/usr/bin/env bash

variable:list() {
  if [[ $# -eq 0 ]]; then local ARGS; read -ra ARGS; ${FUNCNAME[0]} "${ARGS[@]}"; return 0; fi
  local RESULT=() ARG; for ARG in "$@"; do
  local PREFIX="${ARG%%"*"*}" SUFFIXES="${ARG##*"*"}" NAMES NAME
  mapfile -t -d ' ' NAMES < <(eval "echo -n \"\${!${PREFIX}*}\"")
  mapfile -t -d ':' SUFFIXES < <(echo -n "$SUFFIXES")
  if [[ ${#SUFFIXES[@]} -gt 0 ]]; then for SUFFIX in "${SUFFIXES[@]}"; do
  for NAME in "${NAMES[@]}"; do
    if [[ "$NAME" == *"${SUFFIX}" ]]; then RESULT[(( ${#RESULT[@]} + 1 ))]="$NAME"; fi
  done; done else RESULT=( "${NAMES[@]}" ); fi; done; echo -n "${RESULT[@]}"
}
