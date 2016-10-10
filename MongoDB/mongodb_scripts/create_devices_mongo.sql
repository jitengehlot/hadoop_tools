SELECT 
d.device_id,
d.device_type,
d.not_before,
d.not_after,
d.location,
d.sublocation,
d.sublocation_description,
d.model_number,
d.pm_schedule,
d.device_status,
d.notes,
d.canister_config,
d.c_ATMPIntID,
d.c_ATMMake,
d.c_Arrangement,
d.c_Branding,
d.c_Program,
d.c_ServiceVendor,
d.c_ServiceVendorID,
d.c_ServiceVendorReg,
d.c_FLM,
d.c_SLM,
d.c_CommProvider,
d.c_CommType,
d.c_CommDialNumber,
d.c_ArmoredBranch,
d.c_InstalledDate,
d.c_SerialNo,
d.c_MHLSerialNo,
d.c_HostSystem,
d.c_CrossTec,
d.ip_address,
d.location_priority,
d.location_type,
d.device_count,
d.first_line_service_profile,
d.second_line_service_profile,
d.dispatch_esc_first_line,
d.dispatch_esc_second_line,
d.eta_esc_first_line,
d.eta_esc_second_line,
d.onsite_esc_first_line,
d.onsite_esc_second_line,
d.repair_esc_first_line,
d.repair_esc_second_line,
d.clear_esc_first_line,
d.clear_esc_second_line,
d.au,
d.service_team,
d.loc_id,
d.holiday_profile,
d.region,
d.division,
d.host_system,
d.c_prevtermid,
d.c_prevtermidlastwtd,
d.c_atmpzone,
d.c_servicelevel,
d.street_address,
d.city,
d.state,
d.zip,
d.country,
d.phone_number,
d.contact_name,
d.latitude,
d.longitude,
d.c_county,
d.c_latitude,
d.c_longitude,
d.canister_status,
d.location_access_range,
d.location_access_range_l2,
d.location_business_hours,
d.community_read,
d.tmon_monitoring_profile,
d.device_key,
d.tmon_balance_profile,
d.snmp_port,
d.community_write,
d.contact_email,
d.company_key,
d.active,
d.snmp_res_scan_profile,
d.inactivity_profile,
d.component_profile,
d.host_cmd_profile,
d.site_profile,
d.fault_profile,
d.time_zone,
d.th_profile,
d.xmon_profile,
s.summary_name,
st.summary_type,
t.name as tag_name,
t.color_index,
tr.name as time_ranges_name,
trd.start_time,
trd.stop_time,
trdow.name as time_range_dow_name,
c.company_name,
c.short_form_name,
c.company_id,
c.notes,
c.relationship_type,
tz.time_zone,
tz.daylight_saving_name,
tz.gmt_offset,
tz.dst_offset,
tz.dst_start_month,
tz.dst_start_day,
tz.dst_start_time,
tz.dst_start_after,
tz.dst_end_month,
tz.dst_end_day,
tz.dst_end_time,
tz.dst_end_after,
tz.time_zone_description
FROM
devices d 
LEFT OUTER JOIN device_summaries ds ON d.device_key = ds.device_key
LEFT OUTER JOIN device_tags dt ON d.device_key = dt.device_key
LEFT OUTER JOIN summaries s ON ds.summary_key = s.summary_key
LEFT OUTER JOIN summary_types st ON s.summary_type_key = st.summary_type_key
LEFT OUTER JOIN tags t ON dt.tag_key = t.tag_key
LEFT OUTER JOIN time_ranges tr ON d.location_access_range = tr.time_range_key
LEFT OUTER JOIN time_range_days trd ON tr.time_range_key = trd.time_range_key
LEFT OUTER JOIN time_range_dow trdow ON trd.dow = trdow.dow
LEFT OUTER JOIN companies c ON d.company_key = c.company_key
LEFT OUTER JOIN time_zones tz ON d.time_zone = tz.time_zone_key;



-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[device_summaries](
	[device_key] [int] NOT NULL,
	[summary_key] [int] NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[device_tags](
	[device_key] [int] NOT NULL,
	[tag_key] [int] NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[summaries](
	[summary_name] [nvarchar](25) NOT NULL,
	[summary_type_key] [int] NULL,
	[summary_key] [int] NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[summary_types](
	[summary_type_key] [int] NOT NULL,
	[summary_type] [nvarchar](50) NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[tags](
	[tag_key] [int] NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[color_index] [tinyint] NOT NULL,
	[tag_type] [char](1) NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[time_ranges](
	[time_range_key] [int] NOT NULL,
	[name] [varchar](75) NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[time_range_days](
	[time_range_key] [int] NOT NULL,
	[dow] [tinyint] NOT NULL,
	[start_time] [time](0) NOT NULL,
	[stop_time] [time](0) NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[time_range_dow](
	[dow] [tinyint] NOT NULL,
	[name] [char](3) NOT NULL
) ON [PRIMARY]

-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[companies](
	[company_name] [varchar](100) NOT NULL,
	[short_form_name] [varchar](20) NULL,
	[company_id] [varchar](10) NULL,
	[notes] [varchar](255) NULL,
	[company_key] [int] NOT NULL,
	[relationship_type] [tinyint] NOT NULL
) ON [PRIMARY]


-----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[time_zones](
	[time_zone] [varchar](20) NOT NULL,
	[daylight_saving_name] [varchar](50) NULL,
	[gmt_offset] [real] NOT NULL,
	[dst_offset] [real] NULL,
	[dst_start_month] [smallint] NULL,
	[dst_start_day] [varchar](3) NULL,
	[dst_start_time] [datetime] NULL,
	[dst_start_after] [smallint] NULL,
	[dst_end_month] [smallint] NULL,
	[dst_end_day] [varchar](3) NULL,
	[dst_end_time] [datetime] NULL,
	[dst_end_after] [smallint] NULL,
	[time_zone_description] [varchar](255) NULL,
	[time_zone_key] [int] NOT NULL
) ON [PRIMARY]