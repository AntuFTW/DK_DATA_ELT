{% macro convert_author_names_into_list(author_column) %}
{% set ns = namespace(all_author_names=[]) %}
{% set name_list = author_column.split(';') %}
{% for name in name_list %}
    {% set cleaned_name = name.strip() %}
    {% if ',' in name %}
        {% set name_parts = name.split(', ', 1)%}
        {% set final_name = name_parts[1] + ' ' + name_parts[0]%}
    {% else %}
        {% set final_name = name %}
    {% endif %}
    {% do ns.all_author_names.append(final_name) %}
{% endfor %}
    {{all_author_names}}
{% endmacro %}