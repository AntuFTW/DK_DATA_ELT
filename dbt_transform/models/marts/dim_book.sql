select
    DIM_BOOK_ID,
    pa.ISBN as DIM_BOOK_ISBN,
    TITLE as DIM_BOOK_TITLE,
    PUBLISHER as DIM_BOOK_PUBLISHER,
    IMPRINT as DIM_BOOK_IMPRINT,
    PUBLICATION_DATE as DIM_BOOK_PUBLICATION_DATE,
    PRODUCT_GROUP as DIM_BOOK_PRODUCT_GROUP,
    DEPARTMENT as DIM_BOOK_DEPARTMENT,
    SUB_DEPARTMENT as DIM_BOOK_SUB_DEPARTMENT,
    CLASS as DIM_BOOK_CLASS
from
    {{ ref('int_store_sales__preprocess_author') }} as pa
    join
    {{ ref('int_store_sales__generate_unqiue_id_for_isbn') }} as uIDfISBN
    using (ISBN)