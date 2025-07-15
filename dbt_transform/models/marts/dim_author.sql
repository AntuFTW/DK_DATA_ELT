select
    row_number() over (order by AUTHOR_NAME) as DIM_AUTHOR_ID,
    AUTHOR_NAME as DIM_AUTHOR_NAME
from
    {{ ref('int_store_sales__single_author_rows') }}