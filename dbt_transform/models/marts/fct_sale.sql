with sale_events as (
    select
        QTY_SOLD as FCT_SALE_QTY,
        TO_TIME(CREATED_AT) as FCT_SALE_CREATED_AT_TIME,
        TO_TIME(UPDATED_AT) as FCT_SALE_UPDATED_AT_TIME,
        TO_DATE(CREATED_AT) as CREATED_AT_DATE,
        TO_DATE(UPDATED_AT) as UPDATED_AT_DATE,
        DIM_STORE_ID, 
        DIM_BOOK_ID
    from
        {{ ref('int_store_sales__fill_in_null_author') }} fina
        join {{ ref('dim_book') }} db on (fina.ISBN = db.DIM_BOOK_ISBN)
        join {{ ref('dim_store') }} ds on (fina.STORE_NUMBER = ds.DIM_STORE_DK_NUMBER)
),
sale_events_created_at_date_id as (
    select
        FCT_SALE_QTY,
        FCT_SALE_CREATED_AT_TIME,
        FCT_SALE_UPDATED_AT_TIME,
        dd.DIM_DATE_ID as FCT_SALE_CREATED_AT_DATE_ID,
        UPDATED_AT_DATE,
        DIM_STORE_ID,
        DIM_BOOK_ID
    from 
        sale_events se
        join {{ ref('dim_date') }} dd on (se.CREATED_AT_DATE = dd.DIM_DATE_DATE)
),
sale_events_created_and_updated_at_date_id as (
    select
        FCT_SALE_QTY,
        FCT_SALE_CREATED_AT_TIME,
        FCT_SALE_UPDATED_AT_TIME,
        FCT_SALE_CREATED_AT_DATE_ID,
        dd.DIM_DATE_ID as FCT_SALE_UPDATED_AT_DATE_ID,
        DIM_STORE_ID,
        DIM_BOOK_ID
    from 
        sale_events_created_at_date_id secad
        join {{ ref('dim_date') }} dd on (secad.UPDATED_AT_DATE = dd.DIM_DATE_DATE)
)
select
    {{ dbt_utils.generate_surrogate_key([
        'FCT_SALE_CREATED_AT_DATE_ID',
        'FCT_SALE_CREATED_AT_TIME',
        'DIM_STORE_ID',
        'DIM_BOOK_ID'
    ]) }} as FCT_SALE_ID,
    *
from
    sale_events_created_and_updated_at_date_id