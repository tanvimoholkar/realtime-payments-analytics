{% snapshot merchants_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='merchant_id',
        strategy='check',
        check_cols=['merchant_name', 'country_code']
    )
}}

select * from {{ ref('stg_merchants') }}

{% endsnapshot %}