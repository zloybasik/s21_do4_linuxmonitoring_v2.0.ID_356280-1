#!/bin/bash

PART2_DIR="../02"

CHECKS_SH="$PART2_DIR/checks.sh"
PARAM_CHECKS_SH="$PART2_DIR/param_checks.sh"
GENERATE_NAMES_SH="$PART2_DIR/generate_names.sh"
CREATE_ENTITIES_SH="$PART2_DIR/create_entities.sh"

TARGET_DIR="$PART2_DIR"
LOG_DIR="./"
LOG_FILE="$LOG_DIR/clean_$(date +%Y-%m-%d_%H-%M-%S).log"
