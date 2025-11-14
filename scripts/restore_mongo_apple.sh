#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

LATEST_DUMP=$(ls -d "$BACKUP_DIR"/mongo_apple_* 2>/dev/null | sort | tail -n 1)

if [ -z "$LATEST_DUMP" ]; then
  echo "[APPLE][RESTORE] Nenhum dump encontrado em $BACKUP_DIR/mongo_apple_*"
  exit 1
fi

echo "[APPLE][RESTORE] Usando dump: $LATEST_DUMP"

mongorestore \
  --uri "$REPLICA_MONGO_APPLE_URI" \
  --drop \
  "$LATEST_DUMP"

echo "[APPLE][RESTORE] Restore concluído."