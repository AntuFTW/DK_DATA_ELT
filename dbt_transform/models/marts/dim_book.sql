with unique_books as (
    select
        distinct pa.ISBN as DIM_BOOK_ISBN,
        TITLE as DIM_BOOK_TITLE,
        PUBLISHER as DIM_BOOK_PUBLISHER,
        IMPRINT as DIM_BOOK_IMPRINT,
        dd.DIM_DATE_ID as DIM_BOOK_PUBLICATION_DATE_ID,
        PRODUCT_GROUP as DIM_BOOK_PRODUCT_GROUP,
        DEPARTMENT as DIM_BOOK_DEPARTMENT,
        SUB_DEPARTMENT as DIM_BOOK_SUB_DEPARTMENT,
        CLASS as DIM_BOOK_CLASS,
        TO_DATE(CREATED_AT) as DIM_BOOK_RRP_VALID_FROM
    from
        {{ ref('int_store_sales__single_author_rows') }} as pa
        join {{ ref('dim_date') }} as dd on (pa.PUBLICATION_DATE = dd.DIM_DATE_DATE)
)
select
    row_number() over (order by DIM_BOOK_ISBN) as DIM_BOOK_ID,
    *,
    null::DATE as DIM_BOOK_RRP_VALID_TO,
    True as DIM_BOOK_RRP_CURRENTLY_VALID
from
    unique_books 