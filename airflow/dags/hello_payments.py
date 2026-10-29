from datetime import datetime
from airflow.sdk import dag, task

@dag(
    dag_id="hello_payments",
    schedule="@daily",
    start_date=datetime(2026, 10, 1),
    catchup=False,
)
def hello_payments():

    @task
    def extract():
        return {"rows": 30}

    @task(retries=2, retry_delay=timedelta(seconds=10))
    def load(data):
        print(f"Loaded {data['rows']} rows")

    load(extract())

hello_payments()