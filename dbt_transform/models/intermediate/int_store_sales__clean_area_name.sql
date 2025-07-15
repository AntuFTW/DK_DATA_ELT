select
    {{ dbt_utils.star(
		from=ref('stg_store_sales'),
		except=['AREA_NAME']
	) }},
    case
        when AREA_NAME RLIKE 'A[0-9]{2} .+' then SUBSTRING(AREA_NAME, 5, LENGTH(AREA_NAME))
        else AREA_NAME
    end as AREA_NAME
from
    {{ref('stg_store_sales')}}