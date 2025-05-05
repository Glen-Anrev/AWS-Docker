select vehicle_detail_id, gearing_of_gav, nav_in_usd, gav_in_usd, EXTRACT(YEAR FROM reporting_date) as year_reporting_date
                    from dw_inrev_vehicle.vehicle_quarter_view vqv where (vehicle_detail_id, quarter_id,  EXTRACT(YEAR FROM reporting_date)) in
                            (
                                select vehicle_detail_id, max(quarter_id), EXTRACT(YEAR FROM reporting_date) as year_reporting_date
                                from dw_inrev_vehicle.vehicle_quarter_view vqv
                                where gav_in_usd is not null
                                and nav_in_usd is not null and gav_in_usd != 0
                                and nav_in_usd != 0
                                and EXTRACT(QUARTER FROM reporting_date) = 4
                                group by  vehicle_detail_id, year_reporting_date
                                order by vehicle_detail_id
                            )