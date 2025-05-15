select a.record_id from {{ref('investment_intentions_model_2024_staging') }} a
left join (select record_id from {{ref('investment_intentions_model_2025_staging') }} ) b 
on a.record_id = b.record_id limit 100