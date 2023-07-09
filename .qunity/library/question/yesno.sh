#!/usr/bin/env bash

question:yesno() {
  local ANSWER; while read -re -n 1 -p "${*} (Y/n): " ANSWER; do
    case "$ANSWER" in y|Y) return 0 ;; n|N) return 1 ;; *) continue ;; esac
  done
}
