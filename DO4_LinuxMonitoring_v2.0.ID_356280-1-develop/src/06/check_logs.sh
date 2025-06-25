#!/bin/bash

LOG_DIR="../04"
LOG_PATTERN="access_*.log"

check_logs_exist() {
  if [ ! -d "$LOG_DIR" ]; then
    echo "[ERROR] Директория $LOG_DIR не существует."
    return 1
  fi

  if compgen -G "$LOG_DIR/$LOG_PATTERN" > /dev/null; then
    return 0
  else
    echo "[ERROR] Нет лог-файлов по шаблону $LOG_DIR/$LOG_PATTERN"
    return 1
  fi
}

list_logs() {
  echo "[INFO] Найдены логи для анализа в $LOG_DIR:"
  ls -1 "$LOG_DIR"/$LOG_PATTERN
  echo
}
