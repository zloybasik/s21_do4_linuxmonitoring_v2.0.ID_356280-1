#!/bin/bash

log_info() {
  echo "[INFO] $*"
}

log_error() {
  echo "[ERROR] $*" >&2
}

log_debug() {
  echo "[DEBUG] $*"
}
