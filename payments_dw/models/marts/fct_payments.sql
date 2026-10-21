{{ config(materialized='incremental', unique_key='payment_id') }}

select
    payment_id,
    merchant_id,
    amount,
    currency,
    status,
    created_at
from {{ ref('stg_payments') }}

{% if is_incremental() %}
where created_at > (select max(created_at) from {{ this }})
{% endif %}