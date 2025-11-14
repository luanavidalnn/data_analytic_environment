#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

DATE=$(date +%Y%m%d)
DUMP_DIR="$BACKUP_DIR/mongo_apple_$DATE"

echo "[APPLE] Iniciando dump remoto consolidado para $DUMP_DIR"
rm -rf "$DUMP_DIR"
mkdir -p "$DUMP_DIR"

LEN=${#APPLE_MONGO_DBS[@]}

for (( i=0; i<LEN; i++ )); do
  DB_NAME="${APPLE_MONGO_DBS[$i]}"
  PORT="${APPLE_MONGO_PORTS[$i]}"

  echo "[APPLE] Dumpando DB '$DB_NAME' de ${APPLE_MONGO_HOST}:${PORT}"

  mongodump \
    --host "$APPLE_MONGO_HOST" \
    --port "$PORT" \
    --username "$MONGO_ADMIN_USER" \
    --password "$MONGO_ADMIN_PASS" \
    --authenticationDatabase "$AUTH_DB" \
    --db "$DB_NAME" \
    --out "$DUMP_DIR"
done

echo "[APPLE] Dump consolidado concluído em: $DUMP_DIR"