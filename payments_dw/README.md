# Real-Time Payments Analytics Platform

A data engineering project that models payment transactions for analytics. It is built with dbt and DuckDB today, and is designed to grow into a real-time pipeline on Snowflake, Airflow, Spark and Kafka.

## Status

Done: dbt project, seed data (payments, merchants), staging models.
Next: tests, incremental fact table, snapshots, marts, then orchestration and streaming.

## Target architecture

```
payment events -> Kafka -> Spark Streaming -> Snowflake (raw)
                                                  |
                                       dbt (staging -> marts)
                          Airflow orchestrates the whole flow
```

## What's built

- **Seeds:** `raw_payments` (one row per payment) and `raw_merchants` (one row per merchant). The sample payments are deliberately messy, with mixed-case statuses and lowercase currency codes.
- **Staging models** (views): `stg_payments` lowercases `status`, uppercases `currency`, and casts `amount` and `created_at`. `stg_merchants` renames `country` to `country_code`.

## How to run

```bash
git clone <this-repo-url> && cd payments
python3 -m venv venv && source venv/bin/activate
pip install dbt-duckdb
cd payments_dw
```

Add a profile at `~/.dbt/profiles.yml` (kept out of the repo):

```yaml
payments_dw:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: dev.duckdb
      threads: 1
```

```bash
dbt debug && dbt seed && dbt run
dbt show --select stg_payments
```

## Design decisions

- **Staging does only rename, cast and clean**, so raw-data fixes live in one place.
- **Staging models are views**: cheap, always fresh, no storage.
- **DuckDB first, Snowflake later**: free local development, with Snowflake reserved for the final end-to-end run.

