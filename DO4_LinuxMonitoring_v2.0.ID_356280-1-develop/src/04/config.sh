#!/bin/bash

# Коды ответа HTTP:
# 200 - OK
# 201 - Created
# 400 - Bad Request
# 401 - Unauthorized
# 403 - Forbidden
# 404 - Not Found
# 500 - Internal Server Error
# 501 - Not Implemented
# 502 - Bad Gateway
# 503 - Service Unavailable

# Базовая дата для генерации логов (последний день)
BASE_DATE="2025-05-05"

# Коды ответа HTTP
declare -a STATUS_CODES=(200 201 400 401 403 404 500 501 502 503)

# HTTP методы
declare -a METHODS=("GET" "POST" "PUT" "PATCH" "DELETE")

# Пути для URL
declare -a PATHS=("/article" "/post" "/image" "/video")

# User-Agent'ы
declare -a AGENTS=(
  "Mozilla"
  "Google Chrome"
  "Opera"
  "Safari"
  "Internet Explorer"
  "Microsoft Edge"
  "Crawler and bot"
  "Library and net tool"
)

# Минимальное и максимальное число записей в логе
MIN_RECORDS=100
MAX_RECORDS=1000
