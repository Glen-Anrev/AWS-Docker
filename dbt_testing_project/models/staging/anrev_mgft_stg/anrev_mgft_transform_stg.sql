select
        vehicle_detail_id,
        year_reporting_date,
        manager_defined_style as "investment_style",
        case when manager_defined_style = 'Core' then 'Core' else 'Non-Core' end as "core_non_core",
        vehicle_manager_company_name as "Vehicle Company Name",
        vehicle_name,
        case when include_in_anrev_odce_quarterly_index_flag = 1 then 'yes' else 'no' end as odce_index,
        multi_country_or_single_country_flag as country_strategy,
        target_country as singlecountry,
        nav_in_usd as "Current NAV",
        gav_in_usd as "Current GAV",
        case
            when target_country = 'China' or target_country ='Australia' then target_country
            when multi_country_or_single_country_flag = 'multi country' then null
            else 'Other'
        end as singlecountry_edit,
        case when vehicle_update_status_flag = 'liquidated' then 'yes' else 'no' end as liquidation,
        vehicle_structure as "Structure",
        multi_sector_or_single_sector_flag as Sector_Strategy,
        target_sector as Sector_Strategy2,
        first_closing_year as "Year of first Closing",
        case
            when first_closing_year < 2005 then 'A'
            when first_closing_year <= 2008 and first_closing_year >= 2005 then 'B'
            when first_closing_year <= 2014 and first_closing_year >= 2009 then 'C'
            when first_closing_year <= 2017 and first_closing_year >= 2015 then 'D'
            else 'E'
        end as "vintage_edit",
        gearing_of_gav as "Gearing as a % of GAV",
        case 
            when gearing_of_gav < 40 then 'A'
            when gearing_of_gav <= 60 and gearing_of_gav >= 40 then 'B'
            when gearing_of_gav > 60 then 'C'
        end as gearing_edit
    from {{ref('anrev_mgft_base_stg') }}