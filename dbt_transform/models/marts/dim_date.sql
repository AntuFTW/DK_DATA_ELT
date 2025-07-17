with unfiltered_date_dim as (
{{ dbt_date.get_date_dimension("2000-01-01", "2050-12-31") }}
)
select
    {{ dbt_utils.generate_surrogate_key([
        'DATE_DAY'
    ]) }} as DIM_DATE_ID,
    DATE_DAY as DIM_DATE_DATE,
    DAY_OF_WEEK as DIM_DATE_DAY_OF_WEEK,
    DAY_OF_MONTH as DIM_DATE_DAY_OF_MONTH,
    DAY_OF_YEAR as DIM_DATE_DAY_OF_YEAR,
    WEEK_OF_YEAR as DIM_DATE_WEEK_OF_YEAR,
    MONTH_OF_YEAR as DIM_DATE_MONTH_OF_YEAR,
    QUARTER_OF_YEAR as DIM_DATE_QUARTER_OF_YEAR,
    YEAR_NUMBER as DIM_DATE_YEAR_NUMBER,
    MONTH_NAME as DIM_DATE_MONTH_NAME,
    DAY_OF_WEEK_NAME as DIM_DATE_DAY_OF_WEEK_NAME
from
    unfiltered_date_dim