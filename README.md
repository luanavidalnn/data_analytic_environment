# 📊 Data Analytics Environment

Este repositório contém o ambiente completo de **análise de dados**, formado por:

- Réplica dos bancos de produção (MongoDB e InfluxDB)
- Airflow para orquestração
- Grafana para visualização
- Scripts para realizar **dump REMOTO** (a partir da réplica) e **restore LOCAL**
- Rotina automatizada de rotação de backups (7 dias)
- Estrutura modular e isolada para AppleWatch e Fitbit

A produção **não executa nenhum script**.  
Toda a extração/dump acontece **a partir da máquina RÉPLICA**, garantindo segurança e separação total do ambiente analítico.

---

## 🚀 Arquitetura

```bash
PRODUÇÃO (Apple/Fitbit)
├─ expõe portas dos MongoDBs (27017, 27018, ...)
└─ expõe porta do InfluxDB (4241)
▲
| (pull: mongodump / influxd backup)
|
RÉPLICA ────────────────────────────────────────────
├─ Mongo Apple (27017)
├─ Mongo Fitbit (27018)
├─ Influx Apple (8086)
├─ Influx Fitbit (8087)
├─ Airflow (orquestra)
├─ Grafana (dashboard)
└─ Scripts:
├─ dump remoto (mongo/influx)
├─ restore local
├─ cleanup (7 dias)
└─ run_all.sh

---

## 📁 Estrutura do Projeto

```bash
data-analytics/
│
├── replica/
│ ├── docker-compose.yml
│ ├── airflow/
│ │ ├── dags/
│ │ ├── logs/
│ │ └── plugins/
│ │
│ ├── data/
│ │ ├── mongo-apple/
│ │ ├── mongo-fitbit/
│ │ ├── influx-apple/
│ │ ├── influx-fitbit/
│ │ └── grafana/
│ │
│ ├── backups/ # dumps consolidados (7 dias)
│ └── scripts/
│ ├── common.env
│ ├── dump_mongo_apple.sh
│ ├── dump_mongo_fitbit.sh
│ ├── dump_influx_apple.sh
│ ├── dump_influx_fitbit.sh
│ ├── restore_mongo_apple.sh
│ ├── restore_mongo_fitbit.sh
│ ├── restore_influx_apple.sh
│ ├── restore_influx_fitbit.sh
│ ├── cleanup_backups.sh
│ └── run_all.sh
│
└── README.md

---

## 📦 Subindo o ambiente

Na máquina da **RÉPLICA**:

```bash
cd replica
docker compose up -d

Serviços disponíveis:

Serviço	Porta
Grafana	3000
Airflow	8080
Mongo Apple	27017
Mongo Fitbit	27018
Influx Apple	8086
Influx Fitbit	8087


