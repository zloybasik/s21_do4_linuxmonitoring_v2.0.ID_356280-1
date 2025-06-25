#!/bin/bash

param_checks() {
  if [ "$#" -ne 3 ]; then
    echo "Ошибка: требуется 3 параметра."
    echo "Использование: $0 <буквы_папок (до 7)> <буквы_файлов.расширение> <размер_файла (1-100)Mb>"
    exit 1
  fi

  local folder_letters=$1
  local file_param=$2
  local size_raw=$3

  if [ ${#folder_letters} -gt 7 ] || [ ${#folder_letters} -eq 0 ]; then
    echo "Ошибка: буквы для папок должны быть от 1 до 7 символов."
    exit 1
  fi

  if ! [[ "$folder_letters" =~ ^[a-zA-Z]+$ ]]; then
    echo "Ошибка: буквы для папок должны быть только латинскими."
    exit 1
  fi

  if [[ "$file_param" != *.* ]] || [ ${#file_param} -gt 14 ]; then
    echo "Ошибка: неверный формат имени файла (пример: az.az)."
    exit 1
  fi

  local file_name=${file_param%%.*}
  local file_ext=${file_param##*.}

  if [ ${#file_name} -gt 7 ] || [ ${#file_ext} -gt 3 ]; then
    echo "Ошибка: имя файла до 7 символов, расширение до 3."
    exit 1
  fi

  if ! [[ "$file_name" =~ ^[a-zA-Z]+$ ]] || ! [[ "$file_ext" =~ ^[a-zA-Z]+$ ]]; then
    echo "Ошибка: имя и расширение файла должны быть латинскими."
    exit 1
  fi

  if ! [[ "$size_raw" =~ ^[0-9]+(Mb)$ ]]; then
    echo "Ошибка: размер файла должен быть в формате 'числоMb' (пример: 3Mb)."
    exit 1
  fi

  local size_num=${size_raw//Mb/}
  if [ "$size_num" -lt 1 ] || [ "$size_num" -gt 100 ]; then
    echo "Ошибка: размер файла должен быть от 1 до 100 Mb."
    exit 1
  fi
}

parse_size() {
  echo "${1//Mb/}"
}
