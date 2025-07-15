with stock_events as (
    select
        QTY_ON_HAND as FCT_STOCK_STORE_ON_HAND,
        QTY_ON_ORDER as FCT_STOCK_STORE_ON_ORDER,
        QTY_RECEIVED as FCT_STOCK_STORE_RECEIVED,
        QTY_RETURNED as FCT_STOCK_STORE_RETURNED,
        HUB_QTY_ON_HAND as FCT_STOCK_HUB_ON_HAND,
        HUB_QTY_ON_ORDER as FCT_STOCK_HUB_ON_ORDER,
        CREATED_AT as FCT_STOCK_CREATED_AT,
        UPDATED_AT as FCT_STOCK_UPDATED_AT,
        DIM_STORE_ID, 
        DIM_BOOK_ID
    from
        {{ ref('int_store_sales__fill_in_null_author') }} fina
        join {{ ref('dim_book') }} db on (fina.ISBN = db.DIM_BOOK_ISBN)
        join {{ ref('dim_store') }} ds on (fina.STORE_NUMBER = ds.DIM_STORE_DK_NUMBER)
)
select
    row_number() over (order by FCT_STOCK_CREATED_AT) as FCT_SALE_ID,
    *
from
    stock_events