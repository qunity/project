#!/usr/bin/env bash

question:yesno() {
  local ANSWER; while read -r -n 1 -p "${*} (Y/n): " ANSWER < /dev/tty; do
    case "$ANSWER" in y|Y) return 0 ;; n|N) return 1 ;; *) continue ;; esac
  done
}
