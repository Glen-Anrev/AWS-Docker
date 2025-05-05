with base as (
    select
        t.*,
        fc.*,
        m.*,
        case 
            when averagegav_xrvalue != 0 then (total_vehicle_fees + coalesce(performancefees_actualfees_xrvalue, 0) + Vehiclecosts_before_tax) / averagegav_xrvalue
        end as "tger/gav",
        case 
            when averagenav_xrvalue != 0 then (total_vehicle_fees + coalesce(performancefees_actualfees_xrvalue, 0) + Vehiclecosts_before_tax) / averagenav_xrvalue
        end as "tger/nav"
    from {{ref('inrev_mgft_transform_stg') }} t
    join {{ref('inrev_mgft_feecost_stg') }} fc on t.vehicle_detail_id = fc.vehicle_detail_id and t.year_reporting_date = fc.year_reporting_date
    join {{ref('inrev_mgft_metrics_stg') }} m on t.vehicle_detail_id = m.vehicle_detail_id and t.year_reporting_date = m.year_reporting_date
)
SELECT vehicle_id, status, year,
                "investment_style",
                "core_non_core",
                "Vehicle Company Name",
                "Vehicle Name",
                odce_index,
                country_strategy,
                singlecountry,
                current_gav,
                current_nav,
                singlecountry_edit,
                liquidation,
                vehicle_structure as "Structure",
                Sector_Strategy,
                Sector_Strategy2,
                "Year of first Closing",
                vintage_edit,
                vintage_edit_2,
                fund_management_fees,
                fundmanagementfee_actualfees_xrvalue,
                professionalservicescosts_actualfees_xrvalue, vehicleadministrationcosts_actualfees_xrvalue, auditcosts_actualfees_xrvalue, valuationcosts_actualfees_xrvalue, debtarrangementcosts_actualfees_xrvalue, custodiancosts_actualfees_xrvalue, othermiscvehiclecosts_actualfees_xrvalue,
                vehicleformationcostsamortisationfortheperiod_actualfees_xrvalue, bankcharges_actualfees_xrvalue,  deaddealcosts_actualfees_xrvalue, staffcostsifapplicable_actualfees_xrvalue, transferagentcosts_actualfees_xrvalue, corporateincometaxes_actualfees_xrvalue, deferredtaxes_actualfees_xrvalue,
                "Total Vehicle Fees",
                performancefees_actualfees_xrvalue,
                "Vehiclecosts before tax"
                ,averagenav_xrvalue
                ,"VehicleCosts after Tax" ,
                externalleasingcommissions_actualfees_xrvalue,
                propertyacquisitioncosts_actualfees_xrvalue,
                propertyinsurancecosts_actualfees_xrvalue,
                propertymanagementcosts_actualfees_xrvalue,
                repairsandmaintenancecosts_actualfees_xrvalue,
                taxesonpropertyrelatedtoactivities_actualfees_xrvalue,
                utilitiescosts_actualfees_xrvalue,
                othermiscellaneoussundrycosts_actualfees_xrvalue,
                "tger/gav",
                "tger/nav",
                "Property Specific Costs",
                reer,
                reer_status,
                size,
                "performance fee/tgergav",
                performancefees_tgerorreer,
                "vehicle costs/tgergav",
                "management fees/tgergav",
                "performance fee/tgernav",
                "vehicle costs/tgernav",
                "management fees/tgernav",
                "professionalservicescosts_actualfees/tgergav",
                weightedtgergav,
                weightedtgernav,
                reer_fund_management_fees
from base
