#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

DATE=$(date +%Y%m%d)
DUMP_DIR="$BACKUP_DIR/influx_apple_$DATE"

echo "[APPLE][INFLUX] Iniciando backup remoto para $DUMP_DIR"
rm -rf "$DUMP_DIR"
mkdir -p "$DUMP_DIR"

CMD="influxd backup -portable -host ${APPLE_INFLUX_HOST}:${APPLE_INFLUX_PORT}"

# Se auth estiver habilitado na produção:
if [[ -n "$INFLUXDB_ADMIN_USER" && -n "$INFLUXDB_ADMIN_PASS" ]]; then
  CMD="$CMD -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_PASS"
fi

$CMD "$DUMP_DIR"

echo "[APPLE][INFLUX] Backup concluído em: $DUMP_DIR"
