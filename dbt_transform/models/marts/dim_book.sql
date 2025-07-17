with unique_books as (
    select
        distinct pa.ISBN as DIM_BOOK_ISBN,
        TITLE as DIM_BOOK_TITLE,
        PUBLISHER as DIM_BOOK_PUBLISHER,
        RRP as DIM_BOOK_RRP,
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
),
unique_books_date_to_be_normalised as (
    select
        {{ dbt_utils.generate_surrogate_key([
            'DIM_BOOK_ISBN',
            'DIM_BOOK_TITLE',
            'DIM_BOOK_PUBLISHER',
            'DIM_BOOK_RRP',
            'DIM_BOOK_IMPRINT',
            'DIM_BOOK_PUBLICATION_DATE_ID',
            'DIM_BOOK_PRODUCT_GROUP',
            'DIM_BOOK_DEPARTMENT',
            'DIM_BOOK_SUB_DEPARTMENT',
            'DIM_BOOK_CLASS',
            'DIM_BOOK_RRP_VALID_FROM'
        ]) }} as DIM_BOOK_ID,
        *,
        null::DATE as DIM_BOOK_RRP_VALID_TO,
        True as DIM_BOOK_RRP_CURRENTLY_VALID
    from
        unique_books
),
unique_books_valid_from_date_normalised as (
    select
        DIM_BOOK_ID,
        DIM_BOOK_ISBN,
        DIM_BOOK_PUBLISHER,
        DIM_BOOK_IMPRINT,
        DIM_BOOK_PUBLICATION_DATE_ID,
        DIM_BOOK_PRODUCT_GROUP,
        DIM_BOOK_DEPARTMENT,
        DIM_BOOK_SUB_DEPARTMENT,
        DIM_BOOK_CLASS,
        dd.DIM_DATE_ID as DIM_BOOK_RRP_VALID_FROM_DATE_ID,
        DIM_BOOK_RRP_VALID_TO,
        DIM_BOOK_RRP_CURRENTLY_VALID
    from
        unique_books_date_to_be_normalised ubdtbn
        join {{ ref('dim_date') }} as dd on (ubdtbn.DIM_BOOK_RRP_VALID_FROM = dd.DIM_DATE_DATE)
),
unique_books_all_date_normalised as (
    select
        DIM_BOOK_ID,
        DIM_BOOK_ISBN,
        DIM_BOOK_PUBLISHER,
        DIM_BOOK_IMPRINT,
        DIM_BOOK_PUBLICATION_DATE_ID,
        DIM_BOOK_PRODUCT_GROUP,
        DIM_BOOK_DEPARTMENT,
        DIM_BOOK_SUB_DEPARTMENT,
        DIM_BOOK_CLASS,
        DIM_BOOK_RRP_VALID_FROM_DATE_ID,
        dd.DIM_DATE_ID as DIM_BOOK_RRP_VALID_TO_DATE_ID,
        DIM_BOOK_RRP_CURRENTLY_VALID
    from
        unique_books_valid_from_date_normalised ubvfdn
        left join {{ ref('dim_date') }} as dd on (ubvfdn.DIM_BOOK_RRP_VALID_TO = dd.DIM_DATE_DATE)
)
select
    *
from
    unique_books_all_date_normalised
