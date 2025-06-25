#!/bin/bash

USER_CHOICE=""

prompt_user_choice() {
  local choice
  while true; do
    echo "Запустить GoAccess?"
    echo "1 - Да"
    echo "2 - Нет"
    echo "3 - Проверить установлен ли GoAccess"
    read -p "> " choice
    # Убираем пробелы
    choice="${choice#"${choice%%[![:space:]]*}"}"
    choice="${choice%"${choice##*[![:space:]]}"}"
    case "$choice" in
      1|2|3)
        USER_CHOICE="$choice"
        return 0
        ;;
      *)
        echo "Пожалуйста, введите 1, 2 или 3."
        ;;
    esac
  done
}

run_goaccess() {
  echo "[INFO] Запускаем GoAccess..."
  goaccess "$LOG_DIR"/$LOG_PATTERN \
    --log-format=COMBINED \
    --real-time-html \
    --addr=127.0.0.1 \
    --port=7890 \
    --daemonize
  echo "[INFO] GoAccess запущен."
}

cancel_run_message() {
  echo "[INFO] Запуск GoAccess отменён пользователем."
  echo "[INFO] В папке ../06/goaccess/ находится HTML-страница веб-интерфейса GoAccess."
}

error_invalid_input() {
  echo "[ERROR] Некорректный ввод. Скрипт завершён."
}
