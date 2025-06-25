#!/bin/bash

init_log() {
  mkdir -p "$(dirname "$LOG_FILE")"
  touch "$LOG_FILE"
  echo "Лог файл создан: $LOG_FILE"
}

log() {
  local msg="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" | tee -a "$LOG_FILE"
}
