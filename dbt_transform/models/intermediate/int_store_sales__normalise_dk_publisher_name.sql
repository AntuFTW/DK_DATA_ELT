select
    {{ dbt_utils.star(
        from=ref('int_store_sales__clean_area_name'),
        except=['PUBLISHER']
    ) }},
    case
        when PUBLISHER = 'Dk Publishing' then 'Dk'
        else PUBLISHER
    end as PUBLISHER
FROM
    {{ ref('int_store_sales__clean_area_name') }}