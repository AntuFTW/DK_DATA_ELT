select
    AREA_NUMBER
from 
    {{source('store_sales', 'RAW_STORE_SALES')}}
where
    (LENGTH(AREA_NUMBER)=0) OR
    (LENGTH(AREA_NUMBER)>2 AND AREA_NUMBER != '900')