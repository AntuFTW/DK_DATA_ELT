with unique_stores as (
    select
        distinct STORE_NUMBER as DIM_STORE_DK_NUMBER, -- Store number should be unique so we make sure that we get different stores
        STORE_NAME as DIM_STORE_NAME,
        AREA_NUMBER as DIM_STORE_AREA_NUMBER,
        AREA_NAME as DIM_STORE_AREA_NAME
    from
        {{ ref('int_store_sales__fill_in_null_author') }}
)
select
    {{ dbt_utils.generate_surrogate_key([
        'DIM_STORE_DK_NUMBER',
        'DIM_STORE_NAME',
        'DIM_STORE_AREA_NUMBER',
        'DIM_STORE_AREA_NAME'
    ]) }} as DIM_STORE_ID,
    *
from
    unique_stores