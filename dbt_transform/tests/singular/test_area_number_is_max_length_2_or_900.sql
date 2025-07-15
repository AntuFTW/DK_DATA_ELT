select
    AREA_NUMBER
from 
    {{source('store_sales', 'RAW_STORE_SALES')}}
where not
    ((AREA_NUMBER > 0 and AREA_NUMBER < 100) or
    (AREA_NUMBER = 900))