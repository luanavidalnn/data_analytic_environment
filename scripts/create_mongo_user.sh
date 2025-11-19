#!/bin/bash
set -e

MONGO_CONTAINER=${1:-mongo-apple}
MONGO_USER=${2:-root}
MONGO_PASS=${3:-root}

echo "===================================================="
echo "CRIANDO USUÁRIO ROOT NO MONGO LOCAL"
echo "Container: $MONGO_CONTAINER"
echo "User: $MONGO_USER"
echo "===================================================="

echo ">> Entrando no container do Mongo..."
docker exec -i $MONGO_CONTAINER mongosh <<EOF
use admin
db.createUser({
  user: "$MONGO_USER",
  pwd: "$MONGO_PASS",
  roles: [
    { role: "root", db: "admin" },
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "dbAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" }
  ]
})
EOF

echo "===================================================="
echo "Usuário criado com sucesso!"
echo "Agora você pode autenticar com:"
echo "mongodb://$MONGO_USER:$MONGO_PASS@$MONGO_CONTAINER:27017/admin?authSource=admin"
echo "===================================================="
