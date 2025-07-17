select
    *
from
    {{ ref('int_store_sales__clean_area_name') }}
where
    CONTAINS(AREA_NAME, AREA_NUMBER::varchar)