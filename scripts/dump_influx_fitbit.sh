#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

DATE=$(date +%Y%m%d)
DUMP_DIR="$BACKUP_DIR/influx_fitbit_$DATE"

echo "[FITBIT][INFLUX] Iniciando backup remoto para $DUMP_DIR"
rm -rf "$DUMP_DIR"
mkdir -p "$DUMP_DIR"

CMD="influxd backup -portable -host ${FITBIT_INFLUX_HOST}:${FITBIT_INFLUX_PORT}"

# Autenticação se necessário
if [[ -n "$INFLUXDB_ADMIN_USER" && -n "$INFLUXDB_ADMIN_PASS" ]]; then
  CMD="$CMD -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASS"
fi

$CMD "$DUMP_DIR"

echo "[FITBIT][INFLUX] Backup concluído em: $DUMP_DIR"
