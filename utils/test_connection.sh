#!/bin/bash

echo "[UTILS] Testando conexão com SERVIDOR DE PRODUÇÃO E RÉPLICA..."

echo "==> Testando ping PROD..."
ping -c 2 $PROD_HOST || echo "Falha ao conectar PROD"

echo "==> Testando ping RÉPLICA..."
ping -c 2 $REPLICA_HOST || echo "Falha ao conectar RÉPLICA"

echo "==> Testando porta SSH..."
nc -zv $REPLICA_HOST 22 || echo "SSH não disponível"

echo "==> Testando portas Mongo (27017, 27018)..."
nc -zv $REPLICA_HOST 27017
nc -zv $REPLICA_HOST 27018

echo "==> Testando portas Influx (8086, 8087)..."
nc -zv $REPLICA_HOST 8086
nc -zv $REPLICA_HOST 8087

echo "[OK] Conexões testadas."
