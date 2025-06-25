#!/bin/bash

generate_folder_name() {
  local letters=$1
  local min_len=5
  local name=""

  while [ ${#name} -lt "$min_len" ]; do
    name+="${letters:$(( RANDOM % ${#letters} )):1}"
  done

  echo "${name}_$(date +%d%m%y)"
}

generate_file_name() {
  local name_part=$1
  local ext_part=$2
  local min_name_len=5
  local name=""
  local ext=""

  while [ ${#name} -lt "$min_name_len" ]; do
    name+="${name_part:$(( RANDOM % ${#name_part} )):1}"
  done

  while [ ${#ext} -lt 3 ]; do
    ext+="${ext_part:$(( RANDOM % ${#ext_part} )):1}"
  done

  echo "${name}_$(date +%d%m%y).${ext}"
}
