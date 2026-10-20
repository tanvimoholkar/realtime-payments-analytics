select
    payment_id,
    merchant_id,
    cast(amount as decimal(12, 2)) as amount,
    upper(currency) as currency,
    lower(status) as status,
    cast(created_at as timestamp) as created_at
from {{ ref('raw_payments') }}