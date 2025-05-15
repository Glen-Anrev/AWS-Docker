{% test non_null_primary_key(model, col_name) %}
SELECT *
FROM {{ model }}
WHERE {{col_name}} IS NULL
{% endtest %}
