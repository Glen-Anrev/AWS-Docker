select
        vehicle_detail_id,
        year_reporting_date,
        coalesce(fundmanagementfee_actualfees_xrvalue, 0) + coalesce(subscriptionfee_actualfees_xrvalue, 0) + 
        coalesce(assetmanagementfeevehiclelevel_actualfees_xrvalue, 0) + coalesce(propertyacquisitionfeeamortisationfortheperiod_actualfees_xrvalue, 0) + 
        coalesce(commitmentfee_actualfees_xrvalue, 0) + coalesce(propertydispositionfee_actualfees_xrvalue, 0) + 
        coalesce(distributionfee_actualfees_xrvalue, 0) + coalesce(financingfeedebtarrangementfee_actualfees_xrvalue, 0) + 
        coalesce(projectmanagementfee_actualfees_xrvalue, 0) + coalesce(windupfees_actualfees_xrvalue, 0) + 
        coalesce(notspecified_actualfees_xrvalue, 0) as "fund_management_fees",
        performancefees_actualfees_xrvalue,
        professionalservicescosts_actualfees_xrvalue, vehicleadministrationcosts_actualfees_xrvalue, auditcosts_actualfees_xrvalue,
        valuationcosts_actualfees_xrvalue, debtarrangementcosts_actualfees_xrvalue, custodiancosts_actualfees_xrvalue,
        othermiscvehiclecosts_actualfees_xrvalue, vehicleformationcostsamortisationfortheperiod_actualfees_xrvalue, 
        bankcharges_actualfees_xrvalue, deaddealcosts_actualfees_xrvalue, staffcostsifapplicable_actualfees_xrvalue,
        transferagentcosts_actualfees_xrvalue, corporateincometaxes_actualfees_xrvalue, deferredtaxes_actualfees_xrvalue
    from {{ref('anrev_mgft_base_stg') }}