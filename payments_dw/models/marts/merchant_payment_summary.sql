{{ config(materialized='table') }}

select
    m.merchant_id,
    m.merchant_name,
    m.country_code,
    count(s.payment_id) as total_payments,
    count(case when s.status = 'completed' then 1 end) as completed_payments,
    coalesce(sum(s.amount), 0) as total_amount,
    coalesce(sum(case when s.status = 'completed' then s.amount end), 0) as completed_amount
from {{ ref('stg_merchants') }} m
left join {{ ref('stg_payments') }} s
    on s.merchant_id = m.merchant_id
group by m.merchant_id, m.merchant_name, m.country_code