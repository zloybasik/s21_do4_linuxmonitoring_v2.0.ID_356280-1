#!/bin/bash
set -e

source ./checks.sh
source ./param_checks.sh
source ./generate_names.sh
source ./create_entities.sh

param_checks "$@"

FOLDER_LETTERS=$1
FILE_PARAM=$2
SIZE_RAW=$3

SIZE_MB=$(parse_size "$SIZE_RAW")

if [[ "$PWD" == *"/bin"* ]] || [[ "$PWD" == *"/sbin"* ]]; then
  echo "Запуск из каталогов bin или sbin запрещён."
  exit 1
fi

init_log
START_TIME=$(date +%s)
log "Скрипт запущен: $(date +'%Y-%m-%d %H:%M:%S')"

FREE_SPACE_LIMIT_GB=1

FILE_NAME_LETTERS="${FILE_PARAM%%.*}"
FILE_EXT_LETTERS="${FILE_PARAM##*.}"

get_free_space_df_h_gb() {
  df -h / | awk 'NR==2 {print $4}' | sed 's/G//'
}

i=1
while true; do
  FREE_GB=$(get_free_space_df_h_gb)
  log "Свободного места: ${FREE_GB} ГБ"
  # Проверяем, что значение - число (целое или с точкой)
  if ! [[ "$FREE_GB" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    log "Ошибка: не удалось определить свободное место, получено: '$FREE_GB'"
    break
  fi
  # Сравнение с плавающей точкой через bc
  if (( $(echo "$FREE_GB <= $FREE_SPACE_LIMIT_GB" | bc -l) )); then
    log "Остановка: свободного места осталось ${FREE_GB} ГБ (≤ 1 ГБ)"
    break
  fi

  FOLDER_NAME=$(generate_folder_name "$FOLDER_LETTERS")
  create_folder_with_files "$FOLDER_NAME" "$FILE_NAME_LETTERS" "$FILE_EXT_LETTERS" "$SIZE_MB"

  ((i++))
done

END_TIME=$(date +%s)
log "Скрипт завершён: $(date +'%Y-%m-%d %H:%M:%S')"
log "Общее время работы: $(( (END_TIME - START_TIME) / 60 )) мин $(( (END_TIME - START_TIME) % 60 )) сек"
