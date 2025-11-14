#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

DATE=$(date +%Y%m%d)
DUMP_DIR="$BACKUP_DIR/mongo_fitbit_$DATE"

echo "[FITBIT] Iniciando dump remoto consolidado para $DUMP_DIR"
rm -rf "$DUMP_DIR"
mkdir -p "$DUMP_DIR"

LEN=${#FITBIT_MONGO_DBS[@]}

for (( i=0; i<LEN; i++ )); do
  DB_NAME="${FITBIT_MONGO_DBS[$i]}"
  PORT="${FITBIT_MONGO_PORTS[$i]}"

  echo "[FITBIT] Dumpando DB '$DB_NAME' de ${FITBIT_MONGO_HOST}:${PORT}"

  mongodump \
    --host "$FITBIT_MONGO_HOST" \
    --port "$PORT" \
    --username "$MONGO_ADMIN_USER" \
    --password "$MONGO_ADMIN_PASS" \
    --authenticationDatabase "$AUTH_DB" \
    --db "$DB_NAME" \
    --out "$DUMP_DIR"
done

echo "[FITBIT] Dump consolidado concluído em: $DUMP_DIR"