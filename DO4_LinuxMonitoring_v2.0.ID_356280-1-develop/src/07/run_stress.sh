#!/bin/bash

run_stress() {
    if ! command -v stress >/dev/null 2>&1; then
      echo "Утилита stress не установлена. Установите её командой: sudo apt-get install stress"
      exit 1
    fi
    stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s
}
