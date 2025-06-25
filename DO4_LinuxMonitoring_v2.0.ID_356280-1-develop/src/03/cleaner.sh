#!/bin/bash

clean_by_log() {
  local target_dir=$1
  local log_file=$2

  echo "Введите имя лог-файла (с путём, если не в текущей папке):"
  read -r user_log_file
  if [ ! -f "$user_log_file" ]; then
    echo "Ошибка: лог-файл '$user_log_file' не найден!"
    exit 1
  fi

  grep -Eo '/[^ ,]+' "$user_log_file" | sort -u | while read -r path; do
    if [ -e "$path" ]; then
      log "Удаляем $path"
      rm -rf "$path"
    else
      log "Не найден $path"
    fi
  done
}

clean_by_datetime() {
  local target_dir=$1
  local log_file=$2

  echo "Введите время начала в формате 'ГГГГ-ММ-ДД ЧЧ:ММ' (например, 2025-05-01 12:30):"
  read -r start_time_raw
  echo "Введите время конца в формате 'ГГГГ-ММ-ДД ЧЧ:ММ' (например, 2025-05-01 14:00):"
  read -r end_time_raw

  if ! date -d "$start_time_raw" >/dev/null 2>&1 || ! date -d "$end_time_raw" >/dev/null 2>&1; then
    echo "Ошибка: неверный формат даты или времени."
    exit 1
  fi

  start_time=$(date -d "$start_time_raw" "+%Y-%m-%d %H:%M:%S")
  end_time=$(date -d "$end_time_raw" "+%Y-%m-%d %H:%M:%S")

  if [ ! -d "$target_dir" ]; then
    log "Ошибка: каталог '$target_dir' не найден!"
    return
  fi

  if [ "$(date -d "$start_time" +%s)" -gt "$(date -d "$end_time" +%s)" ]; then
    echo "Ошибка: время начала больше времени конца."
    exit 1
  fi

  log "Ищем файлы и папки, созданные между $start_time и $end_time..."

  find "$target_dir" -mindepth 1 \( -type f -o -type d \) -newermt "$start_time" ! -newermt "$end_time" -print0 | while IFS= read -r -d '' item; do
    log "Удаляем $item"
    rm -rf "$item"
  done

  log "Удаление по дате и времени завершено."
}

clean_by_mask() {
  local target_dir=$1
  local log_file=$2

  echo "Введите маску имени (например, azaz_010525, без пути):"
  read -r mask

  log "TARGET_DIR: $target_dir"
  log "mask: $mask"

  find "$target_dir" -mindepth 1 \( -type f -o -type d \) -name "*$mask*" -print0 | while IFS= read -r -d '' item; do
    log "Удаляем $item"
    rm -rf "$item"
  done
}
