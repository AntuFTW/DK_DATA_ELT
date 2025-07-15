select
    {{ dbt_utils.star(
        from=ref('int_store_sales__normalise_dk_publisher_name'),
        except=['AUTHOR']
    ) }},
    case
        when AUTHOR is null then 'No_Author'
        else AUTHOR
    end as AUTHOR
from
    {{ref('int_store_sales__normalise_dk_publisher_name')}}