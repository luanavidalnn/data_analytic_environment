#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

LATEST_DUMP=$(ls -d "$BACKUP_DIR"/mongo_fitbit_* 2>/dev/null | sort | tail -n 1)

if [ -z "$LATEST_DUMP" ]; then
  echo "[FITBIT][RESTORE] Nenhum dump encontrado em $BACKUP_DIR/mongo_fitbit_*"
  exit 1
fi

echo "[FITBIT][RESTORE] Usando dump: $LATEST_DUMP"

mongorestore \
  --uri "$REPLICA_MONGO_FITBIT_URI" \
  --drop \
  "$LATEST_DUMP"

echo "[FITBIT][RESTORE] Restore concluído."