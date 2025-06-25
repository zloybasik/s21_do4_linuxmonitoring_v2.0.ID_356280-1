#!/bin/bash

parse_size() {
    local size_str=$1
    size_str=${size_str,,}
    size_str=${size_str//kb/}
    if ! [[ "$size_str" =~ ^[0-9]+$ ]]; then
        echo "Ошибка: размер файла должен быть числом (с опциональным суффиксом kb)."
        exit 1
    fi
    echo "$size_str"
}

check_file_size() {
    local size=$1
    if [ "$size" -gt 100 ]; then
        echo "Размер файла не может превышать 100 килобайт."
        exit 1
    fi
}

check_free_space() {
    local free_space
    free_space=$(df -k / | awk 'NR==2 {print $4}')
    if [ "$free_space" -lt 1048576 ]; then
        echo "Осталось менее 1 Гб свободного места на диске."
        exit 1
    fi
}

# Функция логирования
log() {
    local msg="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" | tee -a "$LOG_FILE"
}
