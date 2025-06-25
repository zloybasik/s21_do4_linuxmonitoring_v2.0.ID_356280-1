#!/bin/bash

METRICS_DIR="/home/lannwhit/21-school/DO4_LinuxMonitoring_v2.0.ID_356280-1/src/09"
METRICS_FILE="$METRICS_DIR/metrics"
TMP_FILE="$METRICS_DIR/metrics.tmp"

# Сбор метрик CPU
CPU_IDLE1=$(grep 'cpu ' /proc/stat | awk '{print $5}')
TOTAL1=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
sleep 1
CPU_IDLE2=$(grep 'cpu ' /proc/stat | awk '{print $5}')
TOTAL2=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
CPU_USAGE=$(awk "BEGIN { print 100-($CPU_IDLE2-$CPU_IDLE1)*100/($TOTAL2-$TOTAL1) }")

# Сбор метрик памяти
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2 * 1024}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2 * 1024}')

# Сбор метрик по диску
DISK_TOTAL=$(df --output=size -B1 / | tail -1 | tr -d ' ')
DISK_FREE=$(df --output=avail -B1 / | tail -1 | tr -d ' ')

# Формирование файла метрик в формате Prometheus
cat > "$TMP_FILE" <<EOF

# HELP my_cpu_usage_percent CPU usage in percent
# TYPE my_cpu_usage_percent gauge
my_cpu_usage_percent $CPU_USAGE

# HELP my_mem_total_bytes Total memory in bytes
# TYPE my_mem_total_bytes gauge
my_mem_total_bytes $MEM_TOTAL

# HELP my_mem_available_bytes Available memory in bytes
# TYPE my_mem_available_bytes gauge
my_mem_available_bytes $MEM_AVAILABLE

# HELP my_disk_total_bytes Total disk space on / in bytes
# TYPE my_disk_total_bytes gauge
my_disk_total_bytes $DISK_TOTAL

# HELP my_disk_free_bytes Free disk space on / in bytes
# TYPE my_disk_free_bytes gauge
my_disk_free_bytes $DISK_FREE
EOF

# Атомарная замена файла метрик
mv "$TMP_FILE" "$METRICS_FILE"

echo "Собраны метрики CPU, памяти и диска"
