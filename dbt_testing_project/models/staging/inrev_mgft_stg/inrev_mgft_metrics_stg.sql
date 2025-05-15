select
        vehicle_detail_id,
        year_reporting_date,
        coalesce(subscriptionfee_actualfees_xrvalue, 0) + coalesce(fundmanagementfee_actualfees_xrvalue, 0) + 
        coalesce(assetmanagementfeevehiclelevel_actualfees_xrvalue, 0) + coalesce(propertyacquisitionfeeamortisationfortheperiod_actualfees_xrvalue, 0) + 
        coalesce(commitmentfee_actualfees_xrvalue, 0) + coalesce(propertydispositionfee_actualfees_xrvalue, 0) + 
        coalesce(financingfeedebtarrangementfee_actualfees_xrvalue, 0) + coalesce(projectmanagementfee_actualfees_xrvalue, 0) + 
        coalesce(windupfees_actualfees_xrvalue, 0) + coalesce(distributionfee_actualfees_xrvalue, 0) + 
        coalesce(notspecified_actualfees_xrvalue, 0) as total_vehicle_fees,
        performancefees_actualfees_xrvalue,
        coalesce(placementagentcosts_actualfees_xrvalue, 0) + coalesce(auditcosts_actualfees_xrvalue, 0) + 
        coalesce(bankcharges_actualfees_xrvalue, 0) + coalesce(custodiancosts_actualfees_xrvalue, 0) + 
        coalesce(deaddealcosts_actualfees_xrvalue, 0) + coalesce(debtarrangementcosts_actualfees_xrvalue, 0) + 
        coalesce(staffcostsifapplicable_actualfees_xrvalue, 0) + coalesce(professionalservicescosts_actualfees_xrvalue, 0) + 
        coalesce(transferagentcosts_actualfees_xrvalue, 0) + coalesce(valuationcosts_actualfees_xrvalue, 0) + 
        coalesce(vehicleadministrationcosts_actualfees_xrvalue, 0) + coalesce(vehicleformationcostsamortisationfortheperiod_actualfees_xrvalue, 0) + 
        coalesce(othermiscvehiclecosts_actualfees_xrvalue, 0) as "Vehiclecosts_before_tax"
    from {{ref('inrev_mgft_base_stg') }}