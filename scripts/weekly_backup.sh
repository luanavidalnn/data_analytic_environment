#!/bin/bash
set -e

BASE_DIR="/home/ssm/workspace/data_analytic_environment"
LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')

echo "====================================================================="  
echo "[WEEKLY BACKUP - $LOG_TIME] Iniciando backup semanal..."  
echo "====================================================================="  

echo "[1/8] Dump Mongo Apple..."
bash "$BASE_DIR/scripts/dump_mongo_apple.sh"

echo "[2/8] Dump Mongo Fitbit..."
bash "$BASE_DIR/scripts/dump_mongo_fitbit.sh"

echo "[3/8] Dump Influx Apple..."
bash "$BASE_DIR/scripts/dump_influx_apple.sh"

echo "[4/8] Dump Influx Fitbit..."
bash "$BASE_DIR/scripts/dump_influx_fitbit.sh"

echo "[5/8] Restaurando Mongo Apple..."
bash "$BASE_DIR/scripts/restore_mongo_apple.sh"

echo "[6/8] Restaurando Mongo Fitbit..."
bash "$BASE_DIR/scripts/restore_mongo_fitbit.sh"

echo "[7/8] Restaurando Influx Apple..."
bash "$BASE_DIR/scripts/restore_influx_apple.sh"

echo "[8/8] Restaurando Influx Fitbit..."
bash "$BASE_DIR/scripts/restore_influx_fitbit.sh"

LOG_TIME_END=$(date '+%Y-%m-%d %H:%M:%S')
echo "====================================================================="  
echo "[WEEKLY BACKUP - $LOG_TIME_END] Backup semanal concluído!"  
echo "====================================================================="  