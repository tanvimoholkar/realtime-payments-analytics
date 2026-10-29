select
    payment_id,
    merchant_id,
    cast(amount as decimal(12, 2)) as amount,
    upper(currency) as currency,
    {{ clean_status('status') }} as status,
    cast(created_at as timestamp) as created_at
from {{ ref('raw_payments') }}