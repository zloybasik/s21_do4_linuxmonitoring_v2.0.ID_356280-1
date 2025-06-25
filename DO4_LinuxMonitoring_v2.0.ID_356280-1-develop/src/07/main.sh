#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
  1)
    source "$SCRIPT_DIR/run_part2.sh"
    run_part2
    ;;
  2)
    source "$SCRIPT_DIR/run_stress.sh"
    run_stress
    ;;
  3)
    source "$SCRIPT_DIR/check_services.sh"
    check_services
    ;;
  *)
    echo "Использование: $0 [1|2|3]"
    echo "  1 - запуск скрипта из Part 2"
    echo "  2 - запуск stress"
    echo "  3 - проверка наличия Prometheus, Node Exporter и Grafana"
    exit 1
    ;;
esac
