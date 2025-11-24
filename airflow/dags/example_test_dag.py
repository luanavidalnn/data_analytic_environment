from airflow import DAG
from airflow.operators.empty import EmptyOperator
from datetime import datetime

default_args = {
    "owner": "airflow",
}

with DAG(
    dag_id="example_test_dag",
    description="DAG de teste simples para verificar sincronização",
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,   # aparece e só roda manualmente
    catchup=False,
    tags=["teste"],
) as dag:

    start = EmptyOperator(task_id="start")
    end = EmptyOperator(task_id="end")

    start >> end
