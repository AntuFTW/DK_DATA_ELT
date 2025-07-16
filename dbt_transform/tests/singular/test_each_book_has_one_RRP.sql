with unique_RRP_for_each_book as (
    select
        ISBN,
        RRP,
        dense_rank() over (partition by ISBN order by RRP) as RANKING
    from
        {{ source('store_sales', 'RAW_STORE_SALES') }}
)
select
    *
from
    unique_RRP_for_each_book
where
    RANKING >= 2