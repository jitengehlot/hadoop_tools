sqoop import --connect "jdbc:sqlserver://74.208.79.85:1433;username=sa;password=gYY66YfX;database=ctsDM_local" --table devices --hive-table ctsDM.devices --hive-import -m 1


-- correct command
LOAD DATA LOCAL INPATH '/opt/ctsDM/activity_types.csv' INTO TABLE activity_types_orc;

LOAD DATA LOCAL INPATH '/opt/atmtxn' INTO TABLE atmtxn;

LOAD DATA LOCAL INPATH '/opt/ATM_Cardtronics.csv' INTO TABLE temp_report;

CREATE TABLE activity_types_orc (
activity_type_id String,
activity_desc String,
default_template String,
show_in_summary_view String
);


CREATE TABLE activity_types (
activity_type_id String,
activity_desc String,
default_template String,
show_in_summary_view String
) stored as orc;


create table temp_report(
SR_No String,
Name String,
Product_Line String,
Custmer_Name String,
Location_City String,
Location_State String,
Location_Country String,
no_of_atm int,
ATM_transaction int,
installed_atm_year int,
impact String,
service_provider String,
first_incident_key String,
first_incident_fault_id String,
first_incident_fault_text String,
first_incident_category String,
first_incident_category_name String
)
ROW FORMAT
              DELIMITED FIELDS TERMINATED BY ','
              LINES TERMINATED BY '\n' 
              STORED AS TEXTFILE;
			  
grant select on table temp_report to user root;