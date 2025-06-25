#!/bin/bash
set -e

source ./config.sh

source "$CHECKS_SH"
source "$PARAM_CHECKS_SH"
source "$GENERATE_NAMES_SH"
source "$CREATE_ENTITIES_SH"

source ./logger.sh
source ./cleaner.sh

usage() {
  echo "Использование: $0 <способ_очистки>"
  echo "  1 - По лог-файлу"
  echo "  2 - По дате и времени создания"
  echo "  3 - По маске имени"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

MODE=$1

init_log

case "$MODE" in
  1)
    clean_by_log "$TARGET_DIR" "$LOG_FILE"
    ;;
  2)
    clean_by_datetime "$TARGET_DIR" "$LOG_FILE"
    ;;
  3)
    clean_by_mask "$TARGET_DIR" "$LOG_FILE"
    ;;
  *)
    usage
    ;;
esac

log "Очистка завершена."
