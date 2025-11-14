#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

LATEST_DUMP=$(ls -d "$BACKUP_DIR"/influx_fitbit_* 2>/dev/null | sort | tail -n 1)

if [ -z "$LATEST_DUMP" ]; then
  echo "[FITBIT][RESTORE][INFLUX] Nenhum dump encontrado!"
  exit 1
fi

echo "[FITBIT][RESTORE][INFLUX] Restaurando do dump: $LATEST_DUMP"

influxd restore \
  -portable \
  -host "${REPLICA_INFLUX_FITBIT_HOST}:${REPLICA_INFLUX_FITBIT_PORT}" \
  "$LATEST_DUMP"

echo "[FITBIT][RESTORE][INFLUX] Restore concluído."
