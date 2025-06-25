#!/bin/bash

source ./config.sh
source ./logger.sh
source ./reporter.sh

check_args() {
  if [ $# -eq 0 ]; then
    log_error "Параметр не указан."
    echo "Используйте: $0 <1|2|3|4>"
    exit 1
  fi

  if [ $# -gt 1 ]; then
    log_error "Требуется ровно один параметр."
    echo "Используйте: $0 <1|2|3|4>"
    exit 1
  fi

  local param=$1

  if ! [[ "$param" =~ ^[0-9]+$ ]]; then
    log_error "Параметр должен быть числом 1, 2, 3 или 4."
    exit 1
  fi

  if (( param < 1 || param > 4 )); then
    log_error "Параметр должен быть одним из: 1, 2, 3, 4."
    exit 1
  fi

  echo "$param"
}

main() {
  local param
  param=$(check_args "$@") || exit 1

  local output_file="access_${param}.log"

  if process_choice "$param" | tee "$output_file"; then
    log_info "Результат сохранён в файл $output_file"
  fi
}

main "$@"
