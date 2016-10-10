sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table activities --hive-table ctsDM.activities --split-by activity_key --hive-import -m 100

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table availability --hive-table ctsDM.availability --split-by device_key --hive-import -m 100

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table incident_impact_ranges --hive-table ctsDM.incident_impact_ranges --split-by impact_range_key --hive-import -m 100

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table incidents --hive-table ctsDM.incidents_new --split-by fault_key --hive-import -m 100

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table auth_users --hive-table ctsDM.auth_users --hive-import -m 1


sqoop import --connect "jdbc:sqlserver://10.10.29.76:1433;username=sa;password=first#1234;database=EDW" --table atmtxndetails --hive-table default.atmtxndetails --split-by settlementdate --hive-import -m 100

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table DEVICE_INFORMATION --hive-table ctsdm.DEVICE_INFORMATION --split-by MAKE --hive-import -m 10

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table isview_locationdetail_new --hive-table ctsdm.isview_locationdetail_new --hive-import -m 1

sqoop import --connect "jdbc:sqlserver://216.250.125.254:1433;username=sa;password=gYY66YfX;database=ctsDM" --table ATMProcTIDXref --hive-table ctsdm.ATMProcTIDXref --hive-import -m 1