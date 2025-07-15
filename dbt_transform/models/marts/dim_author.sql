with unique_authors as (
    select
        distinct f.value::string as DIM_AUTHOR_NAME -- 'value' contains each element from the array
    from
        {{ ref('int_store_sales__preprocess_author') }} s,
        lateral FLATTEN(INPUT => s.AUTHOR_ARRAY) f
)
select
    row_number() over (order by DIM_AUTHOR_NAME) as DIM_AUTHOR_ID,
    DIM_AUTHOR_NAME
from
    unique_authors