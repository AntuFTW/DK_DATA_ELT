SELECT
    *
FROM
    {{ref('int_store_sales__clean_area_name')}}
WHERE AREA_NAME RLIKE 'A[0-9]{2} .+'