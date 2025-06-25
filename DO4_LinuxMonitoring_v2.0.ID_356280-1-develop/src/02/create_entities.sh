#!/bin/bash

create_file() {
  local filename=$1
  local size_mb=$2
  dd if=/dev/zero of="$filename" bs=1M count="$size_mb" status=none
}

create_folder_with_files() {
  local folder_name=$1
  local file_name_letters=$2
  local file_ext_letters=$3
  local size_mb=$4

  mkdir -p "$folder_name"

  local folder_size_mb
  folder_size_mb=$(du -sm "$folder_name" | cut -f1)
  log "Папка: $(realpath "$folder_name"), Дата создания: $(date +'%Y-%m-%d %H:%M:%S'), Размер: ${folder_size_mb} МБ"

  cd "$folder_name" || { log "Ошибка: не удалось перейти в папку $folder_name"; exit 1; }

  local file_count=$(( RANDOM % 10 + 1 ))
  for ((j=1; j<=file_count; j++)); do
    local file_name
    file_name=$(generate_file_name "$file_name_letters" "$file_ext_letters")
    create_file "$file_name" "$size_mb"

    local file_size_mb
    file_size_mb=$(du -m "$file_name" | cut -f1)
    log "Файл: $(realpath "$file_name"), Дата создания: $(date +'%Y-%m-%d %H:%M:%S'), Размер: ${file_size_mb} МБ"
  done

  cd - > /dev/null || exit 1
}
