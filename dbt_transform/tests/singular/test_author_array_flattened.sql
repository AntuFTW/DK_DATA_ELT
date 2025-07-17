with input_model as (
    select
        sum(array_size(author_array)) as total_authors
    from 
        {{ ref('int_store_sales__preprocess_author') }}
),
output_model as (
    select
        count(*) as total_rows
    from
        {{ ref('int_store_sales__single_author_rows') }}
)
select
    total_authors,
    total_rows
from
    input_model im
    cross join output_model om
where total_authors != total_rows