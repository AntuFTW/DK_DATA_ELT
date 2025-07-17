with unique_book_valid_from as (
    select
        ISBN,
        RRP,
        TITLE,
        PUBLISHER,
        IMPRINT,
        PUBLICATION_DATE,
        PRODUCT_GROUP,
        DEPARTMENT,
        SUB_DEPARTMENT,
        CLASS,
        min(CREATED_AT::date) as VALID_FROM
    from
        {{ ref('int_store_sales__single_author_rows') }}
    group by
        ISBN,
        RRP,
        TITLE,
        PUBLISHER,
        IMPRINT,
        PUBLICATION_DATE,
        PRODUCT_GROUP,
        DEPARTMENT,
        SUB_DEPARTMENT,
        CLASS
),
unique_book_valid_from_and_to as (
    select
        *,
        lead(VALID_FROM) over (partition by ISBN order by VALID_FROM) as VALID_TO
    from
        unique_book_valid_from
),
dim_book_no_date_id as (
    select
        ISBN as DIM_BOOK_ISBN,
        TITLE as DIM_BOOK_TITLE,
        PUBLISHER as DIM_BOOK_PUBLISHER,
        PUBLICATION_DATE as DIM_BOOK_PUBLICATION_DATE,
        IMPRINT as DIM_BOOK_IMPRINT,
        RRP as DIM_BOOK_RRP,
        PRODUCT_GROUP as DIM_BOOK_PRODUCT_GROUP,
        DEPARTMENT as DIM_BOOK_DEPARTMENT,
        SUB_DEPARTMENT as DIM_BOOK_SUB_DEPARTMENT,
        CLASS as DIM_BOOK_CLASS,
        VALID_FROM as DIM_BOOK_RRP_VALID_FROM,
        VALID_TO as DIM_BOOK_RRP_VALID_TO,
        (VALID_TO is null) as DIM_BOOK_RRP_CURRENTLY_VALID -- The flag is now dynamic
    from
        unique_book_valid_from_and_to
),
date_id_joined as (
    select
        DIM_BOOK_ISBN,
        DIM_BOOK_TITLE,
        DIM_BOOK_PUBLISHER,
        DIM_BOOK_IMPRINT,
        DIM_BOOK_RRP,
        DIM_BOOK_PRODUCT_GROUP,
        DIM_BOOK_DEPARTMENT,
        DIM_BOOK_SUB_DEPARTMENT,
        DIM_BOOK_CLASS,
        DIM_BOOK_RRP_CURRENTLY_VALID,
        dim_date_pub_date.DIM_DATE_ID as DIM_BOOK_PUBLICATION_DATE_ID,
        dim_date_valid_from.DIM_DATE_ID as DIM_BOOK_RRP_VALID_FROM_DATE_ID,
        dim_date_valid_to.DIM_DATE_ID as DIM_BOOK_RRP_VALID_TO_DATE_ID
    from 
        dim_book_no_date_id dbndID
        join dim_date dim_date_pub_date on (dbndID.DIM_BOOK_PUBLICATION_DATE = dim_date_pub_date.DIM_DATE_DATE)
        join dim_date dim_date_valid_from on (dbndID.DIM_BOOK_RRP_VALID_FROM = dim_date_valid_from.DIM_DATE_DATE)
        left join dim_date dim_date_valid_to on (dbndID.DIM_BOOK_RRP_VALID_TO = dim_date_valid_to.DIM_DATE_DATE)
)
select
    {{ dbt_utils.generate_surrogate_key([
    'DIM_BOOK_ISBN',
    'DIM_BOOK_RRP',
    'DIM_BOOK_TITLE',
    'DIM_BOOK_PUBLISHER',
    'DIM_BOOK_IMPRINT',
    'DIM_BOOK_PUBLICATION_DATE_ID',
    'DIM_BOOK_RRP_VALID_FROM_DATE_ID',
    'DIM_BOOK_PRODUCT_GROUP',
    'DIM_BOOK_DEPARTMENT',
    'DIM_BOOK_SUB_DEPARTMENT',
    'DIM_BOOK_CLASS']) }} as DIM_BOOK_ID,
    *
from
    date_id_joined