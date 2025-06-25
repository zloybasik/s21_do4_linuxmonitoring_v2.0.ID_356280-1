#!/bin/bash

generate_file_name() {
    local letters=$1
    local date=$2

    local name_part=${letters%%.*}
    local ext_part=${letters##*.}

    local name=""
    local ext=""

    for letter in $(echo "$name_part" | fold -w1); do
        name+=$letter
    done

    while [ ${#name} -lt 5 ]; do
        name+=${name_part:$(( RANDOM % ${#name_part} )):1}
    done

    for letter in $(echo "$ext_part" | fold -w1); do
        ext+=$letter
    done

    while [ ${#ext} -lt 3 ]; do
        ext+=${ext_part:$(( RANDOM % ${#ext_part} )):1}
    done

    echo "${name}_$date.${ext}"
}

create_file() {
    local filename=$1
    local size_kb=$2
    dd if=/dev/zero of="$filename" bs=1024 count="$size_kb" status=none
}
