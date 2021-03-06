SELECT  i.device_key
		,i.incident_key
		,f.fault_id
		,f.fault_text
		,i.opened_dtimestamp
		,i.closed_dtimestamp
		,i.ack_dtimestamp
		,i.onsite_dtimestamp
		,i.repair_dtimestamp
		,isnull(i.ack_sla_actual, 0) AS "ack_sla_actual"
		,isnull(i.onsite_sla_actual, 0) AS "onsite_sla_actual"
		,isnull(i.repair_sla_actual, 0) AS "repair_sla_actual"
		,i.ext_user_ref

	FROM ctsdm_local.dbo.incidents i WITH (NOLOCK)
		--LEFT JOIN ctsdm_local.dbo.incident_tags it WITH (NOLOCK) 
		--	on i.incident_key = it.incident_key
		JOIN ctsdm_local.dbo.faults f WITH (NOLOCK) ON i.fault_key = f.fault_key
		--LEFT JOIN ctsdm_local.dbo.categories c WITH (NOLOCK) ON c.category_key = f.category_key
		--LEFT JOIN ctsdm_local.dbo.category_groups cg WITH (NOLOCK) ON cg.category_group_Key = c.category_group_key
		--LEFT JOIN ctsdm_local.dbo.devices d WITH (NOLOCK) ON i.device_key = d.device_key
		--LEFT JOIN ctsdm_local.dbo.device_summaries ds WITH (NOLOCK) ON i.device_key = ds.device_key
		--LEFT JOIN ctsdm_local.dbo.companies co WITH (NOLOCK) ON i.service_provider =co.company_key

		select distinct(fault_key) from faults;2917
		select * from incidents where fault_key='2014-05-29 09:02:31.770000000';
		update incidents set fault_key=2917 where incident_key=18865;
