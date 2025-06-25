#!/bin/bash

check_services() {
  echo "Проверка наличия Prometheus, Node Exporter и Grafana..."

  PROMETHEUS_BIN=$(command -v prometheus)
  if [[ -z "$PROMETHEUS_BIN" ]]; then
    for path in /usr/local/bin/prometheus /usr/local/prometheus/prometheus /opt/prometheus/prometheus; do
      if [[ -x "$path" ]]; then
        PROMETHEUS_BIN="$path"
        break
      fi
    done
  fi

  NODE_EXPORTER_BIN=$(command -v node_exporter)
  GRAFANA_BIN=$(command -v grafana-server)

  PROMETHEUS_SVC=$(systemctl is-active prometheus 2>/dev/null)
  NODE_EXPORTER_SVC=$(systemctl is-active node_exporter 2>/dev/null)
  GRAFANA_SVC=$(systemctl is-active grafana-server 2>/dev/null)

  if [[ -n "$PROMETHEUS_BIN" ]]; then
    echo "Prometheus найден: $PROMETHEUS_BIN"
    if [[ "$PROMETHEUS_SVC" == "active" ]]; then
      echo "Сервис prometheus: работает"
    else
      echo "Сервис prometheus: не работает или не найден"
    fi
  else
    if [[ "$PROMETHEUS_SVC" == "active" ]]; then
      echo "Prometheus бинарник не найден, но сервис prometheus работает!"
    else
      echo "Prometheus НЕ найден!"
    fi
  fi

  if [[ -n "$NODE_EXPORTER_BIN" ]]; then
    echo "Node Exporter найден: $NODE_EXPORTER_BIN"
    if [[ "$NODE_EXPORTER_SVC" == "active" ]]; then
      echo "Сервис node_exporter: работает"
    else
      echo "Сервис node_exporter: не работает или не найден"
    fi
  else
    echo "Node Exporter НЕ найден!"
  fi

  if [[ -n "$GRAFANA_BIN" ]]; then
    echo "Grafana найден: $GRAFANA_BIN"
    if [[ "$GRAFANA_SVC" == "active" ]]; then
      echo "Сервис grafana-server: работает"
    else
      echo "Сервис grafana-server: не работает или не найден"
    fi
  else
    echo "Grafana НЕ найдена!"
  fi
}
