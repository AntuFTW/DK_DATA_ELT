select
    DIM_AUTHOR_ID,
    DIM_BOOK_ID
from
    {{ ref('int_store_sales__single_author_rows') }} sar
    join {{ ref('dim_author') }} da on (sar.AUTHOR_NAME = da.DIM_AUTHOR_NAME)
    join {{ ref('dim_book') }} db on (sar.ISBN = db.DIM_BOOK_ISBN)