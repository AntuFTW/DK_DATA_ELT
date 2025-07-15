with distinct_ISBN as (
    select
        distinct ISBN
    from
        {{ ref('int_store_sales__preprocess_author') }}
)
select
    row_number() over (order by ISBN) as DIM_BOOK_ID,
    ISBN
from
    distinct_ISBN