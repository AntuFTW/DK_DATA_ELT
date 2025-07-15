    select
        {{ dbt_utils.star(
            from=ref('int_store_sales__preprocess_author'),
            except=['AUTHOR_ARRAY']
        ) }},
        f.value::string as AUTHOR_NAME -- 'value' is column with unpacked authors
    from
        {{ ref('int_store_sales__preprocess_author') }} s,
        lateral FLATTEN(INPUT => s.AUTHOR_ARRAY) f