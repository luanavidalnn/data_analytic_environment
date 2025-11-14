#!/bin/bash

BASE="/opt/data-analytics/replica/backups"

echo "[UTILS] Verificando dumps mais recentes..."

for DB in mongo_apple mongo_fitbit influx_apple influx_fitbit; do
  LAST=$(ls -dt $BASE/${DB}_* 2>/dev/null | head -n1)

  if [ -z "$LAST" ]; then
    echo "❌ Nenhum backup encontrado para: $DB"
  else
    AGE=$(expr $(date +%s) - $(date -r "$LAST" +%s))
    AGE_DAYS=$(( AGE / 86400 ))

    if (( AGE_DAYS > 2 )); then
      echo "⚠️  Último backup de $DB tem $AGE_DAYS dias ($LAST)"
    else
      echo "✅ Ok: $DB — último backup em $LAST"
    fi
  fi
done
