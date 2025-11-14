#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.env"

echo "[CLEANUP] Removendo dumps com mais de 7 dias em $BACKUP_DIR..."

find "$BACKUP_DIR" -maxdepth 1 -type d \( -name "mongo_apple_*" -o -name "mongo_fitbit_*" \) -mtime +7 -print -exec rm -rf {} \;

echo "[CLEANUP] Concluído."