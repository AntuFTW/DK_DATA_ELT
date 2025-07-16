with unique_authors as (
select
    distinct AUTHOR_NAME as DIM_AUTHOR_NAME
from
    {{ ref('int_store_sales__single_author_rows') }}
)
select
    {{ dbt_utils.generate_surrogate_key([
        'DIM_AUTHOR_NAME'
    ]) }} as DIM_AUTHOR_ID,
    *
from
    unique_authors