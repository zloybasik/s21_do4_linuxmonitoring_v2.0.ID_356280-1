#!/bin/bash

source ./check_logs.sh
source ./goaccess.sh
source ./check_services.sh

main() {
  # Проверка через аргумент
  if [[ "$1" == "3" ]]; then
    check_goaccess
    exit 0
  fi

  if ! check_logs_exist; then
    exit 1
  fi

  list_logs

  if [[ "$1" == "1" ]]; then
    run_goaccess
    exit 0
  elif [[ "$1" == "2" ]]; then
    cancel_run_message
    exit 0
  fi

  prompt_user_choice

  echo "[DEBUG] Выбран вариант: '$USER_CHOICE'"

  case "$USER_CHOICE" in
    1)
      run_goaccess
      ;;
    2)
      cancel_run_message
      ;;
    3)
      check_goaccess
      ;;
    *)
      error_invalid_input
      exit 1
      ;;
  esac
}

main "$@"
