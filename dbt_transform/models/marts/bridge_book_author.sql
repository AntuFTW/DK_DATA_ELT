with author_book_relation as (
    select
        distinct DIM_BOOK_ID,
        DIM_AUTHOR_ID
    from
        {{ ref('int_store_sales__single_author_rows') }} sar
        join {{ ref('dim_author') }} da on (sar.AUTHOR_NAME = da.DIM_AUTHOR_NAME)
        join {{ ref('dim_book') }} db on (sar.ISBN = db.DIM_BOOK_ISBN)
)
select
    {{ dbt_utils.generate_surrogate_key([
        'DIM_BOOK_ID',
        'DIM_AUTHOR_ID'
    ]) }} as BRIDGE_BOOK_AUTHOR_ID,
    *
from 
    author_book_relation