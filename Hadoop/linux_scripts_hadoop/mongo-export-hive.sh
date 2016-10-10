#!/bin/bash

## bash script change by Vikas Parashar on Aug 4, 2014
## This script is use for Opus Soft only
## In this script for monitoring purpose, we are using the nagios plugins.


mongo_db_host="10.10.29.23"
hdp_host="10.10.29.23"
#DESTINATION=10.10.26.45

now=$(date +"%Y-%m-%d")
filename="/var/log/testscript.$now.log"
#DATE=$(date +%b-%e-%T)

HOSTNAME=$(hostname)

status_op_s="0"
error_op_s="0"




#Function will take the command and service as a argument
#Return value would be redirect in log file
function check_command
{
	command=$1
	service=$2
	$command &> /tmp/abc 
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 $service `hostname` $MSG" >>  $filename
		echo > /tmp/abc
		status_op_s=1
	else
		MSG=`cat /tmp/abc`
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 $service `hostname` $MSG" >>  $filename
		echo > /tmp/abc
		error_op_s=1
		exit;
	fi
}





#check_command "/usr/lib64/nagios/plugins/check_ping -H 127.0.0.1 -w 3000.0,80% -c 5000.0,100% -p 5"

#To check resouremanager
echo "----------------Resouce manager checking started----------------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_webui.sh resourcemanager $hdp_host 8088" "resourcemanager"

#To check resoure manager process
echo "----------------Resouce manager process checking started---------------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_tcp -H $hdp_host -p 8088 -w 1 -c 1" "resource manager process"

#To check Node Manager process
echo "----------------Node manager process checking started-----------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_tcp -H $hdp_host -p 8042 -w 1 -c 1" "nodemanager process"

#To check Hive server process
echo "----------------Hive server process checking started---------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_tcp -H $hdp_host -p 10000 -w 1 -c 1" "Hive Server Process"

#To check Hive meta store process
echo "----------------Hive meta store process checking started----------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_tcp -H $hdp_host -p 9083 -w 1 -c 1" "Hive Meta Store Process"

#To check Mongodb server process
echo "----------------Mongodb server process checking started----------For more informtion, kindly check /tmp/abc----->" >> $filename
check_command "/usr/lib64/nagios/plugins/check_tcp -H $mongo_db_host -p 27017 -w 1 -c 1" "Mongodb server"






###@2nd phase

##Perl code 
##create a perl code to check the regex of output
pwd=`/bin/pwd`
cat > $pwd/perl.pl << EOF
#!/usr/bin/perl
\$arg=\$ARGV[0];
if ( \$arg =~ /^((19|20)\d\d-).*$/ ){
	print \$arg;
} else {
	print \$arg;
}
EOF

#above is bug in script, we shall check it later



echo "----------------Check settlement data -------------For more informtion, kindly check /tmp/abc----->" >> $filename
#check_command '/usr/bin/hive -e "use test; select max(settlementdate) from atmtxn_orc"' "Hive"
/usr/bin/hive -e "use test; select max(settlementdate) from atmtxn_orc;" &> /tmp/abc
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 Hive `hostname` $MSG" >>  $filename

			IFS="\n";

			if [ -f $pwd/perl.pl ]; then
				for i in `cat /tmp/abcc | tail -n 2 |  grep -v Time `
				do
					`/usr/bin/perl -w $pwd/perl.pl \"$i\" &> /tmp/vikas` 
					 
					mytime=`cat /tmp/vikas | sed 's/"//g'`;


				done
			else
				echo "$now	ERROR Perl script `hostname` file perl.pl not found" >>  $filename
			fi 

			IFS=" ";

		#echo > /tmp/abc
		status_op_s=1
	else
		MSG=`cat /tmp/abc`
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 Hive `hostname` Error in hive " >>  $filename
		echo > /tmp/abc
		error_op_s=1
		exit;
	fi







echo "----------------Trying to increasing date -------------For more informtion, kindly check /tmp/date----->" >> $filename
	#RETVAL=$?
        #if [ $RETVAL -eq 0 ]; then
				#mytime="2014-01-01 05:00:00"
		mytime1=`echo $mytime | awk '{print $1}'`
		mytime2=`echo $mytime | awk '{print $2}'`
		#mytime1=
		echo `date  "+%C%y-%m-%d" -d "$mytime1 +1 day"`" "`echo $mytime2` > /tmp/date
		#`date  "+%C%y-%m-%d %T" -d "$mytime +1 day" > /tmp/date`
		 newdate=`cat /tmp/date  | sed 's/ /T/'  | sed "s/$/.000Z/"`
		 hive_orc_date=`cat /tmp/date`
	#	echo $newdate
	#	echo $v
	#fi

## need to discuss about the time format..... 


##create a js file for mongo queries
cat > $pwd/test.js << EOF
cursor = db.trans.find({SD:ISODate("$newdate")}).count();
printjson(cursor);
EOF



if [ -f $pwd/test.js ]; then
	#cd $pwd
	/usr/bin/mongo  --host $mongo_db_host card_cr --eval 'printjson(load("test.js"))' &> /tmp/abc 
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 mongo  `hostname` get data from mongo." >>  $filename
		totalmongo=`cat /tmp/abc | tail -n 2 | head -n 1`
		echo > /tmp/abc
		status_op_s=1
	else
		MSG=`cat /tmp/abc`
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 mongo `hostname` In get dat from mongo" >>  $filename
		echo > /tmp/abc
		error_op_s=1
		exit;
	fi
fi




echo "----------------Expoting data from MongoDB server----------------------" >> $filename
cat > /tmp/mongo.sh << EOF
mongoexport -h $mongo_db_host --out txn.csv --db card_cr --collection trans --csv --fields _id,OD,RD,PD,TL,TT,RC,RJ,BD,ND,TS,SD,ST,AD,AT,AM,FE,SR,IC,TN,OB,ET,LD,PN,PT,PR,PC,P1,P2,AI,EP,IL,IT,IR,BR,DT,CD,DA,DL,DX,D7,CC,H4,H5,H6,H7,H8,H9,HA,HB,HC,HM,PA --query '{ SD : { "\$date": "$newdate" } }'
EOF
	/bin/bash /tmp/mongo.sh  &> /tmp/abc
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 mongo  `hostname` exporting data from mongodb $MSG" >>  $filename
		status_op_s=1
	else
		MSG=`cat /tmp/abc`
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 mongo `hostname` exporting data from mongodb $MSG" >>  $filename
		error_op_s=1
		exit;
	fi

##check the file created or not

#> txn.csv
echo "----------------Generating CSV file -------------> for any problem please see txn-new-sc.csv" >> $filename
	[ -s txn.csv ]
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		if [ -f $pwd/txn.csv ]; then
			tail -n +2 txn.csv > txn-new-wc.csv;
			sed -i 's/"//g'  txn-new-wc.csv
				[ -s txn-new-wc.csv ]
				RETVAL=$?
				if [ $RETVAL -eq 0 ]; then
					echo "----------------csv file generated successfully-----" >> $filename
				else
					echo "FAILURE--------there is some error in csv file at time of manipution. kindly check tsxn-new-wc.csv-----" >> $filename
					exit;
				fi
				
			fi
	else 
		echo "----------------there is some error in csv file. kindly check it-----" >> $filename
		exit;
	fi



echo "----------------Loading data to Hive staging table----------------------" >> $filename

hive -e "use test;LOAD DATA LOCAL INPATH 'txn-new-wc.csv' OVERWRITE INTO TABLE atmtxn_staging" &> /tmp/abc
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 Hive  `hostname` uploading csv in staging table..$MSG" >>  $filename
		status_op_s=1
	else
		MSG=`cat /tmp/abc`
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 Hive `hostname` uploading csv in staging table..$MSG" >>  $filename
		error_op_s=1
		exit;
	fi


echo "----------------Inserting data to Hive ORC table----------------------" >> $filename
cat > /tmp/hive.sh << EOF
hive -e "SET hive.exec.dynamic.partition = true; SET hive.exec.dynamic.partition.mode = nonstrict;  use test; insert into table atmtxn_orc PARTITION (SettlementDate) select InternalID ,OldID ,RecordInternalID ,ProcessorID ,Terminal ,TxnTypeID ,ResponseCodeID ,RejectCodeID ,BankID ,NetworkID ,TerminalSequenceNumber ,SettlementTime ,ActivityDate ,ActivityTime ,Amount ,Fee ,Surcharge ,Interchange ,Txn ,OurBank ,EBTTransaction ,LogID ,P_NetworkCode ,P_TxnCode ,P_ResponseCode ,P_RejectCode ,P_Field1 ,P_Field2 ,ATMInternalID ,EP ,InterchangeCalc ,International ,IchgRateID ,Branded ,DenyTxnType ,CardID ,DCCAmount ,DCCTotal ,DCCTXn ,Deny711 ,CountryCode ,HP4 ,HP5 ,HP6 ,HP7 ,HP8 ,HP9 ,HP10 ,HP11 ,HP12 ,HP13, HP14, HP15, HPCATM ,PAN,from_unixtime(unix_timestamp(concat(substr(SettlementDate,1,10),' ',substr(SettlementDate,12,12)),'yyyy-MM-dd HH:mm:ss.SSS'))  from atmtxn_staging where settlementdate = '$newdate';";
EOF
	su - hdfs -c "/bin/bash /tmp/hive.sh" &> /tmp/abc
	#$HIVE_INS &> /tmp/abc
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		MSG=`cat /tmp/abc`
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 HIVE  `hostname` inserting data in Hive in  ORC format $MSG" >>  $filename
		echo > /tmp/abc
		status_op_s=1
	else
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 HIVE `hostname` inserting data in HIve in ORC format" >>  $filename
		error_op_s=1
		exit;
	fi

echo "----------------Count on Hive data----------------------" >> $filename

hive -e "use test; select count(*) from atmtxn_orc where settlementdate ='$hive_orc_date';" &> /tmp/abc
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then	
		ALEVEL="SUCCESS"
		echo "$now	$ALEVEL	 Hive  `hostname` count data from hive" >>  $filename
		totalhadoop=`cat /tmp/abc | tail -n 2 | head -n 1`
		status_op_s=1
	else
		ALEVEL="FAILURE"
		echo "$now	$ALEVEL	 Hive `hostname` count data from hive" >>  $filename
		error_op_s=1
		exit;
	fi


if [ $error_op_s -eq 1 ]; then
	echo "there is some error. Kindly check it";
else 
	echo "please check it";
fi

echo "totalmongo value is $totalmongo"
echo "totalhadoop value is $totalhadoop"
if [ $totalmongo -eq $totalhadoop ]; then
	echo "Test is pass; "
else 
	echo "failure";
fi 

exit;


