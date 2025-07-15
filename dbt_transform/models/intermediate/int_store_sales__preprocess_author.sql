select
    {{ dbt_utils.star(
        from=ref('int_store_sales__fill_in_null_author'),
        except=['AUTHOR']
    ) }},
    split(AUTHOR, ';') as AUTHOR_ARRAY
from
    {{ ref('int_store_sales__fill_in_null_author') }}