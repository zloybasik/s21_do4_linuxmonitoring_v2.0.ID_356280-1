
#!/bin/bash
source ./config.sh
source ./logger.sh

generate_ip() {
  printf "%d.%d.%d.%d" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
}

generate_status() {
  echo "${STATUS_CODES[RANDOM % ${#STATUS_CODES[@]}]}"
}

generate_method() {
  echo "${METHODS[RANDOM % ${#METHODS[@]}]}"
}

generate_path() {
  echo "${PATHS[RANDOM % ${#PATHS[@]}]}"
}

generate_agent() {
  echo "${AGENTS[RANDOM % ${#AGENTS[@]}]}"
}

generate_url() {
  local path
  path=$(generate_path)
  local id=$((RANDOM % 1000 + 1))
  local ext=$([[ $((RANDOM % 2)) -eq 0 ]] && echo ".html" || echo ".php")
  echo "${path}/${id}${ext}"
}

generate_log_file() {
  local day_offset=$1
  local date_str
  date_str=$(date -d "$BASE_DATE -$day_offset days" +"%d-%m-%Y")
  local file_name="access_${date_str}.log"
  local records=$(( RANDOM % (MAX_RECORDS - MIN_RECORDS + 1) + MIN_RECORDS ))
  local day_start
  day_start=$(date -d "$BASE_DATE -$day_offset days" +%s)
  local current_time=$day_start

  log_info "Генерация $file_name (записей: $records)"

  > "$file_name"

  for ((i=0; i<records; i++)); do
    local ip method status time_local url agent

    ip=$(generate_ip)
    status=$(generate_status)
    method=$(generate_method)
    current_time=$((current_time + RANDOM % 60 + 1))
    time_local=$(date -d "@$current_time" +"%d/%b/%Y:%H:%M:%S")
    url=$(generate_url)
    agent=$(generate_agent)

    echo "$ip - - [$time_local +0000] \"$method $url HTTP/1.1\" $status 512 \"-\" \"$agent\"" >> "$file_name"
  done
}
