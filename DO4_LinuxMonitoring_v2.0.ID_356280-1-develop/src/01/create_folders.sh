#!/bin/bash

generate_folder_name() {
    local letters=$1
    local date=$2
    local name=""

    for letter in $(echo "$letters" | fold -w1); do
        name+=$letter
    done

    while [ ${#name} -lt 4 ]; do
        name+=${letters:$(( RANDOM % ${#letters} )):1}
    done

    name+="_$date"

    echo "$name"
}
