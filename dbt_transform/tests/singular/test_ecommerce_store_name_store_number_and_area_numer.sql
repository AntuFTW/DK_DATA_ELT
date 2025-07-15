with ecommerce as (
    select
        *
    from
        {{source('store_sales', 'RAW_STORE_SALES')}}
    WHERE AREA_NAME = 'Ecommerce'
)
select
    *
from
    ecommerce
where not
    (STORE_NUMBER=888 AND STORE_NAME='Waterstones.com (Bookhub)' AND AREA_NUMBER=900)