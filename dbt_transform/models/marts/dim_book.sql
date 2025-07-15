with unique_books as (
select
    distinct pa.ISBN as DIM_BOOK_ISBN,
    TITLE as DIM_BOOK_TITLE,
    PUBLISHER as DIM_BOOK_PUBLISHER,
    IMPRINT as DIM_BOOK_IMPRINT,
    PUBLICATION_DATE as DIM_BOOK_PUBLICATION_DATE,
    PRODUCT_GROUP as DIM_BOOK_PRODUCT_GROUP,
    DEPARTMENT as DIM_BOOK_DEPARTMENT,
    SUB_DEPARTMENT as DIM_BOOK_SUB_DEPARTMENT,
    CLASS as DIM_BOOK_CLASS
from
    {{ ref('int_store_sales__single_author_rows') }} as pa
)
select
    row_number() over (order by DIM_BOOK_ISBN) as DIM_BOOK_ID,
    *
from
    unique_books