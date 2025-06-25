#!/bin/bash
set -euo pipefail

source ./config.sh
source ./logger.sh
source ./generator.sh

for day in {0..4}; do
  generate_log_file "$day"
done

log_info "Генерация логов завершена."
