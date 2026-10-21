select
    merchant_id,
    merchant_name,
    country as country_code
from {{ ref('raw_merchants') }}