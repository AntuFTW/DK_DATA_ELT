{% test test_timestamp_in_past(model, column_name) %}

select
    *
from
    {{model}}
where {{column_name}} > LOCALTIMESTAMP

{% endtest %}