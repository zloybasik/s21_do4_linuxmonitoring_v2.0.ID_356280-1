#!/bin/bash

source ./checks.sh
source ./create_folders.sh
source ./create_files.sh

if [ "$#" -ne 6 ]; then
    echo "Неправильное количество параметров."
    echo "Использование: $0 <путь> <количество_папок> <буквы_для_папок> <количество_файлов> <буквы_для_файлов> <размер_файлов>"
    exit 1
fi

DIR_PATH=$1
FOLDERS=$2
FOLDER_LETTERS=$3
FILES=$4
FILE_LETTERS=$5
SIZE_RAW=$6

SIZE=$(parse_size "$SIZE_RAW")

check_file_size "$SIZE"

check_free_space

mkdir -p "$DIR_PATH" || { echo "Не удалось создать директорию $DIR_PATH"; exit 1; }
cd "$DIR_PATH" || { echo "Не удалось перейти в директорию $DIR_PATH"; exit 1; }

DIR_NAME=$(basename "$PWD")
LOG_FILE="${DIR_NAME}_$(date +%Y-%m-%d_%H-%M-%S).log"
touch "$LOG_FILE"

DATE=$(date +%d%m%y)

log "Начало создания папок и файлов в $PWD"

for ((i=0; i < FOLDERS; i++)); do
    folder_name=$(generate_folder_name "$FOLDER_LETTERS" "$DATE")
    mkdir -p "$folder_name"

    folder_size_kb=$(du -sk "$folder_name" | cut -f1)
    log "Папка: $PWD/$folder_name, Дата создания: $(date), Размер: ${folder_size_kb} КБ"

    cd "$folder_name" || exit 1

    for ((j=0; j < FILES; j++)); do
        file_name=$(generate_file_name "$FILE_LETTERS" "$DATE")
        create_file "$file_name" "$SIZE"
        file_size_kb=$(du -k "$file_name" | cut -f1)
        log "Файл: $PWD/$file_name, Дата создания: $(date), Размер: ${file_size_kb} КБ"
    done

    cd .. || exit 1
done

total_size=$(du -sh . | cut -f1)
log "Общий размер директории $PWD: $total_size"

log "Создание завершено. Лог записан в $LOG_FILE."
