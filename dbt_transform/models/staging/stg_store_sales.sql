select
	{{ dbt_utils.star(
		from=source('store_sales', 'RAW_STORE_SALES'),
		except=['PUBLICATION_DATE']
	) }},
	TO_DATE(PUBLICATION_DATE, 'DD/MM/YYYY') as PUBLICATION_DATE
from {{source('store_sales', 'RAW_STORE_SALES')}}