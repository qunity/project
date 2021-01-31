#!/usr/bin/env bash

# +----------------------------------------------------------------------------+
# |                                                                            |
# | This file is part of the Qunity package.                                   |
# |                                                                            |
# | Copyright (c) Rodion Kachkin <kyleRQWS@gmail.com>                          |
# |                                                                            |
# | For the full copyright and license information, please view the LICENSE    |
# | file that was distributed with this source code.                           |
# |                                                                            |
# +----------------------------------------------------------------------------+

# ------------------------------------------------------------------------------
# Load file
# [<file>[!] ...]
# ------------------------------------------------------------------------------
function Shell::Load::File() {
  declare file=""
  declare -a files=()

  if [[ $# -eq 0 ]]; then
    while read -r file; do files+=("$file"); done
    ${FUNCNAME[0]} "${files[@]}"; return
  fi

  IFS=$'\n'
  while [[ $# -gt 0 ]]; do
    case "$1" in
      *"!")
        for file in ${1%%+("!")}; do
          files+=("$(readlink --canonicalize-missing "$file")")
        done
      ;;
      *)
        for file in $1; do
          if [[ ! -f "$file" ]]; then continue; fi
          files+=("$(readlink --canonicalize-missing "$file")")
        done
      ;;
    esac

    shift
  done
  IFS=$' \t\n'

  for file in "${files[@]}"; do
    # shellcheck source=/dev/null
    if ! source "$file"; then false; return; fi
  done
}

# ------------------------------------------------------------------------------
# Load shell item
# [<item>[!] ...]
# ------------------------------------------------------------------------------
function Shell::Load() {
  declare item="" flag=""
  declare -a items=() files=()

  if [[ $# -eq 0 ]]; then
    while read -r item; do items+=("$item"); done
    ${FUNCNAME[0]} "${items[@]}"; return
  fi

  for item in "$@"; do
    flag=""
    if [[ "${item: -1}" == "!" ]]; then
      item="${item%%+("!")}"; flag="!"
    fi

    files+=("${BASE_DIR}/project/dev/shell/${item//":"/"/"}.sh${flag}")
  done

  Shell::Load::File "${files[@]}"
}

# ------------------------------------------------------------------------------
# Start
# ------------------------------------------------------------------------------
set -o errexit -o errtrace -o pipefail -o nounset
shopt -s extglob

declare -g BASE_DIR
BASE_DIR="$(readlink --canonicalize-existing --verbose "$(dirname "$0")/../../../")"
readonly BASE_DIR

Shell::Load "action:${1}!"
Shell::Execute "${@:2}"
