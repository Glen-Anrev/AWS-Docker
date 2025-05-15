-- This test will fail if any `id` in my_model is NULL
SELECT *
FROM {{ ref('investment_intentions_model_2024_2024') }}
WHERE record_id IS NULL
