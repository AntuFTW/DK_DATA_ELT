select
    *
from
    {{ ref('int_store_sales__preprocess_author') }}
where
    contains(AUTHOR, ';') and
    array_size(AUTHOR_ARRAY) = 1
