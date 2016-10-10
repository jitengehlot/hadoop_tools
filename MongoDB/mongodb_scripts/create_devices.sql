CREATE TABLE [dbo].[devices](
	[device_id] [varchar](25) NOT NULL,
	[device_type] [varchar](10) NULL,
	[not_before] [datetime] NULL,
	[not_after] [datetime] NULL,
	[location] [varchar](50) NULL,
	[sublocation] [varchar](5) NULL,
	[sublocation_description] [varchar](65) NULL,
	[model_number] [varchar](25) NULL,
	[pm_schedule] [int] NULL,
	[device_status] [varchar](25) NULL,
	[notes] [varchar](255) NULL,
	[canister_config] [varchar](10) NULL,
	[c_ATMPIntID] [varchar](20) NULL,
	[c_ATMMake] [varchar](20) NULL,
	[c_Arrangement] [varchar](20) NULL,
	[c_Branding] [varchar](20) NULL,
	[c_Program] [varchar](20) NULL,
	[c_ServiceVendor] [varchar](10) NULL,
	[c_ServiceVendorID] [varchar](20) NULL,
	[c_ServiceVendorReg] [varchar](20) NULL,
	[c_FLM] [varchar](20) NULL,
	[c_SLM] [varchar](20) NULL,
	[c_CommProvider] [varchar](20) NULL,
	[c_CommType] [varchar](20) NULL,
	[c_CommDialNumber] [varchar](20) NULL,
	[c_ArmoredBranch] [varchar](50) NULL,
	[c_InstalledDate] [varchar](10) NULL,
	[c_SerialNo] [varchar](50) NULL,
	[c_MHLSerialNo] [varchar](10) NULL,
	[c_HostSystem] [varchar](20) NULL,
	[c_CrossTec] [varchar](10) NULL,
	[ip_address] [varchar](39) NULL,
	[location_priority] [varchar](50) NULL,
	[location_type] [varchar](50) NULL,
	[device_count] [varchar](50) NULL,
	[first_line_service_profile] [int] NULL,
	[second_line_service_profile] [int] NULL,
	[dispatch_esc_first_line] [int] NULL,
	[dispatch_esc_second_line] [int] NULL,
	[eta_esc_first_line] [int] NULL,
	[eta_esc_second_line] [int] NULL,
	[onsite_esc_first_line] [int] NULL,
	[onsite_esc_second_line] [int] NULL,
	[repair_esc_first_line] [int] NULL,
	[repair_esc_second_line] [int] NULL,
	[clear_esc_first_line] [int] NULL,
	[clear_esc_second_line] [int] NULL,
	[au] [varchar](10) NULL,
	[service_team] [varchar](10) NULL,
	[loc_id] [varchar](50) NULL,
	[holiday_profile] [int] NULL,
	[region] [varchar](50) NULL,
	[division] [varchar](50) NULL,
	[host_system] [varchar](20) NULL,
	[c_prevtermid] [varchar](20) NULL,
	[c_prevtermidlastwtd] [varchar](20) NULL,
	[c_atmpzone] [varchar](10) NULL,
	[c_servicelevel] [varchar](20) NULL,
	[street_address] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](25) NULL,
	[zip] [varchar](15) NULL,
	[country] [varchar](50) NULL,
	[phone_number] [varchar](25) NULL,
	[contact_name] [varchar](50) NULL,
	[latitude] [decimal](9, 6) NULL,
	[longitude] [decimal](9, 6) NULL,
	[c_county] [varchar](20) NULL,
	[c_latitude] [varchar](20) NULL,
	[c_longitude] [varchar](20) NULL,
	[canister_status] [varchar](10) NULL,
	[location_access_range] [int] NULL,
	[location_access_range_l2] [int] NULL,
	[location_business_hours] [int] NULL,
	[community_read] [varchar](128) NULL,
	[tmon_monitoring_profile] [int] NULL,
	[device_key] [int] NOT NULL,
	[tmon_balance_profile] [int] NULL,
	[snmp_port] [smallint] NULL,
	[community_write] [varchar](128) NULL,
	[contact_email] [nvarchar](256) NULL,
	[company_key] [int] NULL,
	[active] [bit] NULL,
	[snmp_res_scan_profile] [int] NULL,
	[inactivity_profile] [int] NULL,
	[component_profile] [int] NULL,
	[host_cmd_profile] [int] NULL,
	[site_profile] [int] NULL,
	[fault_profile] [int] NULL,
	[time_zone] [int] NOT NULL,
	[th_profile] [int] NULL,
	[xmon_profile] [int] NULL
) ON [PRIMARY]

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