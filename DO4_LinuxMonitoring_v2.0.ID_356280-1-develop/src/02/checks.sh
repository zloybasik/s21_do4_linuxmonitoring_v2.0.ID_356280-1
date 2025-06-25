#!/bin/bash

LOG_FILE="script_$(date +%Y-%m-%d_%H-%M-%S).log"

init_log() {
  touch "$LOG_FILE"
  echo "Лог файл создан: $LOG_FILE"
}

log() {
  local msg="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" | tee -a "$LOG_FILE"
}

check_free_space() {
  local path=${1:-/}
  df -BG "$path" | awk 'NR==2 {print $4}' | sed 's/G//'
}
