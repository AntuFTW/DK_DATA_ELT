with stock_events as (
    select
        QTY_ON_HAND as FCT_STOCK_UPDATE_STORE_ON_HAND,
        QTY_ON_ORDER as FCT_STOCK_UPDATE_STORE_ON_ORDER,
        QTY_RECEIVED as FCT_STOCK_UPDATE_STORE_RECEIVED,
        QTY_RETURNED as FCT_STOCK_UPDATE_STORE_RETURNED,
        HUB_QTY_ON_HAND as FCT_STOCK_UPDATE_HUB_ON_HAND,
        HUB_QTY_ON_ORDER as FCT_STOCK_UPDATE_HUB_ON_ORDER,
        TO_TIME(CREATED_AT) as FCT_STOCK_UPDATE_CREATED_AT_TIME,
        TO_TIME(UPDATED_AT) as FCT_STOCK_UPDATE_UPDATED_AT_TIME,
        TO_DATE(CREATED_AT) as CREATED_AT_DATE,
        TO_DATE(UPDATED_AT) as UPDATED_AT_DATE,
        CORE_STOCK_FLAG as FCT_STOCK_UPDATE_CORE_STOCK_FLAG,
        DIM_STORE_ID, 
        DIM_BOOK_ID
    from
        {{ ref('int_store_sales__fill_in_null_author') }} fina
        join {{ ref('dim_book') }} db on (fina.ISBN = db.DIM_BOOK_ISBN)
        join {{ ref('dim_store') }} ds on (fina.STORE_NUMBER = ds.DIM_STORE_DK_NUMBER)
),
stock_events_created_at_date_id as (
    select
        FCT_STOCK_UPDATE_STORE_ON_HAND,
        FCT_STOCK_UPDATE_STORE_ON_ORDER,
        FCT_STOCK_UPDATE_STORE_RECEIVED,
        FCT_STOCK_UPDATE_STORE_RETURNED,
        FCT_STOCK_UPDATE_HUB_ON_HAND,
        FCT_STOCK_UPDATE_HUB_ON_ORDER,
        FCT_STOCK_UPDATE_CREATED_AT_TIME,
        FCT_STOCK_UPDATE_UPDATED_AT_TIME,
        dd.DIM_DATE_ID as FCT_STOCK_UPDATE_CREATED_AT_DATE_ID,
        UPDATED_AT_DATE,
        FCT_STOCK_UPDATE_CORE_STOCK_FLAG,
        DIM_STORE_ID,
        DIM_BOOK_ID
    from
        stock_events se
        join {{ ref('dim_date') }} dd on (se.CREATED_AT_DATE = dd.DIM_DATE_DATE)
),
stock_events_created_and_updated_at_date_id as (
    select
        FCT_STOCK_UPDATE_STORE_ON_HAND,
        FCT_STOCK_UPDATE_STORE_ON_ORDER,
        FCT_STOCK_UPDATE_STORE_RECEIVED,
        FCT_STOCK_UPDATE_STORE_RETURNED,
        FCT_STOCK_UPDATE_HUB_ON_HAND,
        FCT_STOCK_UPDATE_HUB_ON_ORDER,
        FCT_STOCK_UPDATE_CREATED_AT_TIME,
        FCT_STOCK_UPDATE_UPDATED_AT_TIME,
        FCT_STOCK_UPDATE_CREATED_AT_DATE_ID,
        dd.DIM_DATE_ID as FCT_STOCK_UPDATE_UPDATED_AT_DATE_ID,
        FCT_STOCK_UPDATE_CORE_STOCK_FLAG,
        DIM_STORE_ID,
        DIM_BOOK_ID
    from
        stock_events_created_at_date_id secadi
        join {{ ref('dim_date') }} dd on (secadi.UPDATED_AT_DATE = dd.DIM_DATE_DATE)
)
select
    {{ dbt_utils.generate_surrogate_key([
        'FCT_STOCK_UPDATE_CREATED_AT_TIME',
        'FCT_STOCK_UPDATE_CREATED_AT_DATE_ID',
        'DIM_STORE_ID',
        'DIM_BOOK_ID'
    ]) }} as FCT_STOCK_UPDATE_ID,
    *
from
    stock_events_created_and_updated_at_date_id