#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

LATEST_DUMP=$(ls -d "$BACKUP_DIR"/influx_apple_* 2>/dev/null | sort | tail -n 1)

if [ -z "$LATEST_DUMP" ]; then
  echo "[APPLE][RESTORE][INFLUX] Nenhum dump encontrado!"
  exit 1
fi

echo "[APPLE][RESTORE][INFLUX] Restaurando do dump: $LATEST_DUMP"

influxd restore \
  -portable \
  -host "${REPLICA_INFLUX_APPLE_HOST}:${REPLICA_INFLUX_APPLE_PORT}" \
  "$LATEST_DUMP"

echo "[APPLE][RESTORE][INFLUX] Restore concluído."
