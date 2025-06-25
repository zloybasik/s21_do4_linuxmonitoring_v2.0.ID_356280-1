#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Использование: $0 1|2"
    echo "Параметр 1 - тесты из Part 7"
    echo "Параметр 2 - сетевой тест iperf3"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
    1)
        "$SCRIPT_DIR/run_part7.sh"
        ;;
    2)
        "$SCRIPT_DIR/run_iperf3.sh"
        ;;
    *)
        echo "Неизвестный параметр: $1"
        echo "Использование: $0 1|2"
        echo "Параметр 1 - тесты из Part 7"
        echo "Параметр 2 - сетевой тест iperf3"
        exit 1
        ;;
esac
