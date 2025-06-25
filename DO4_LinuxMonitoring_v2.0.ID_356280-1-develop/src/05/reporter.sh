#!/bin/bash

process_choice() {
  case "$1" in
    1)
      cat "${LOG_FILES[@]}" | awk '{print $9 "\t" $0}' | sort -n | cut -f2-
      ;;
    2)
      cat "${LOG_FILES[@]}" | awk '{print $1}' | sort -u
      ;;
    3)
      cat "${LOG_FILES[@]}" | awk '$9 ~ /^[45]/ {match($0, /"[^"]+"/); print $9, substr($0, RSTART+1, RLENGTH-2)}'
      ;;
    4)
      cat "${LOG_FILES[@]}" | awk '$9 ~ /^[45]/ {print $1}' | sort -u
      ;;
    *)
      log_error "Неверный параметр для запуска скрипта"
      exit 1
      ;;
  esac
}
