#!/bin/bash

check_goaccess() {
  echo "Проверка наличия GoAccess..."

  GOACCESS_BIN=$(command -v goaccess)

  if [[ -n "$GOACCESS_BIN" ]]; then
    echo "GoAccess найден: $GOACCESS_BIN"
    GOACCESS_VER=$("$GOACCESS_BIN" --version 2>&1 | head -n1)
    echo "Версия: $GOACCESS_VER"
  else
    echo "GoAccess НЕ найден!"
    echo "Установите GoAccess командой: sudo apt-get install goaccess"
  fi
}
