#! /bin/bash

#######################################################################################
# Author: Jitendra Gehlot
# Filename: mongo_hive_ETL.sh
# Date: 10/10/2016
# Description: This script use to ETL Daily Load from MongoDB to 
#			   HIVE table. In this script for monitoring purpose,nagios plugin is used.
#######################################################################################

#mongo_db_host="10.10.29.23"
mongo_db_host="74.208.11.129"
hdp_host="198.251.76.5"
#DESTINATION=10.10.26.45

now=$(date +"%Y-%m-%d %T")
now_log=$(date +"%Y-%m-%d")
filename="/var/log/testscript.$now_log.log"
#DATE=$(date +%b-%e-%T)

HOSTNAME=$(hostname)

status_op_s="0"
error_op_s="0"


##variable for the starting time for scripts
old_c=`date  "+%C%y-%m-%d %T"`

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
                echo "$now      $ALEVEL  $service `hostname` $MSG" >>  $filename
                echo > /tmp/abc
                status_op_s=1
        else
                MSG=`cat /tmp/abc`
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  $service `hostname` $MSG" >>  $filename
                echo > /tmp/abc
                error_op_s=1
                exit;
        fi
}

##function will write the time difference of steps in logs
##parameter $1 and $2 for old and new date
function date_diff(){
# convert the date "1970-01-01 hour:min:00" in seconds from Unix EPOCH time
sec_old=$(date -d "$1" +%s)
sec_new=$(date -d "$2" +%s)

echo "the difference is $((sec_new - sec_old)) seconds"  >> $filename
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

function comment_c(){
##Perl code
##create a perl code to check the regex of output
pwd=`/bin/pwd`
cat > /tmp/perl.pl << EOF
#!/usr/bin/perl
\$arg=\$ARGV[0];
if ( \$arg =~ /^((19|20)\d\d-).*$/ ){
        print \$arg;
} else {
        print \$arg;
}
EOF

#above is bug in script, we shall check it later
###################STEP 1


echo "----------------Check settlement data -------------For more informtion, kindly check /tmp/abc----->" >> $filename
#check_command '/usr/bin/hive -e "use test; select max(settlementdate) from atmtxn_orc"' "Hive"
#/usr/bin/hive -e "use test; select max(settlementdate) from atmtxn_orc;" &> /tmp/abc
/usr/bin/hive -e "use default; select max(settlementdate) from transactions_bin_orc;" &> /tmp/abc
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                MSG=`cat /tmp/abc`
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  Hive `hostname` $MSG" >>  $filename

                        IFS="\n";

                        if [ -f /tmp/perl.pl ]; then
                                for i in `cat /tmp/abc | tail -n 2 |  grep -v Time `
                                do
                                        `/usr/bin/perl -w /tmp/perl.pl \"$i\" &> /tmp/opus`

                                        mytime=`cat /tmp/opus | sed 's/"//g'`;


                                done
                        else
                                echo "$now      ERROR Perl script `hostname` file perl.pl not found" >>  $filename
                        fi

                        IFS=" ";

                #echo > /tmp/abc
                status_op_s=1
        else
                MSG=`cat /tmp/abc`
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  Hive `hostname` Error in hive $MSG " >>  $filename
                echo > /tmp/abc
                error_op_s=1
                exit;
        fi




#ISODate("2014-01-01T05:00:00.000Z")

###################STEP 2
echo "----------------Trying to increasing date -------------For more informtion, kindly check /tmp/date----->" >> $filename
                mytime1=`echo $mytime | awk '{print $1}'`
                mytime2=`echo $mytime | awk '{print $2}'`
                incdate=`date  "+%C%y-%m-%d" -d "$mytime1 +1 day"`
                echo $incdate" 05:00:00" > /tmp/date
                #echo `date  "+%C%y-%m-%d" -d "$mytime1 +1 day"`" "`echo $mytime2` > /tmp/date
                 #newdate=`cat /tmp/date  | sed 's/ /T/'  | sed "s/$/.000Z/"`
                 newdate=`cat /tmp/date  | sed 's/ /T/'  | sed "s/$/.000Z/"`
                 hive_orc_date="$incdate 00:00:00.0"

#echo $mytime;
#echo $newdate;
#echo $hive_orc_date;
#exit;

}
#===========///////////////////===============
newdate="2014-01-03T05:00:00.000Z"
hive_orc_date="2014-01-03 00:00:00.0"

#-------------------------
old=`date  "+%C%y-%m-%d %T"`



## need to discuss about the time format.....
#############STEP 3 ################
echo "----------------Trying to increasing date -------------For more informtion, kindly check /tmp/date----->" >> $filename

##create a js file for mongo queries
cat > /tmp/test.js << EOF
cursor = db.transactions.find({SD:ISODate("$newdate")}).count();
printjson(cursor);
EOF



if [ -f /tmp/test.js ]; then
        #cd /tmp
        /usr/bin/mongo  --host $mongo_db_host cardtronics  --eval 'printjson(load("/tmp/test.js"))' &> /tmp/abc
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                MSG=`cat /tmp/abc`
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  mongo  `hostname` get data from mongo status = $MSG" >>  $filename
                totalmongo=`cat /tmp/abc | tail -n 2 | head -n 1`
                echo > /tmp/abc
                status_op_s=1
        else
                MSG=`cat /tmp/abc`
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  mongo `hostname` In get dat from mongo status = $MSG" >>  $filename
                echo > /tmp/abc
                error_op_s=1
                exit;
        fi
fi

#--------------------------
new=`date  "+%C%y-%m-%d %T"`
date_diff $old $new

#echo $totalmongo;
#	exit;

if [ $totalmongo -eq 0 ]; then
        echo "no record to insert, kindly check it" >> $filename
        exit;
fi

#-------------------------
old=`date  "+%C%y-%m-%d %T"`

#############STEP 4 ################
###Road map ; need to check it..
echo "--------------- Removing yesterday collection-------------For more informtion, kindly check /tmp/abc----->" >> $filename

        `/usr/bin/mongo  --host $mongo_db_host cardtronics  --eval "db.transactions_Bin_1day.drop()" &> /tmp/abc`
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                MSG=`cat /tmp/abc`
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  mongo  `hostname` in removing collection = $MSG" >>  $filename
                echo > /tmp/abc
                status_op_s=1
        else
                MSG=`cat /tmp/abc`
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  mongo `hostname` in removing collection = $MSG" >>  $filename
                echo > /tmp/abc
                error_op_s=1
                exit;
        fi


#--------------------------
new=`date  "+%C%y-%m-%d %T"`
date_diff $old $new

#############STEP 5 ################

#-------------------------
old=`date  "+%C%y-%m-%d %T"`

echo "----------------Creating a new collection----------------------" >> $filename
cat > /tmp/collection.js << EOF
function f(n) { return n < 10 ? '0' + n : n; }
        db.transactions.find({"SD" : ISODate("$newdate")}).forEach(
            function(myDoc)
            {

                for (var key in myDoc)
                {

                   if (myDoc.hasOwnProperty(key) && key=='SD')
                   {
                        myDoc.SD = myDoc[key].getUTCFullYear() + "-" +
                                                        f((myDoc[key].getUTCMonth()+1)) + "-" +
                                                        f(myDoc[key].getUTCDate()) + " " + "00:00:00.0";
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='H6')
                   {
                                   myDoc.H6 = myDoc.H6.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='H7')
                   {
                                   myDoc.H7 = myDoc.H7.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='H8')
                   {
                                   myDoc.H8 = myDoc.H8.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='H9')
                   {
                                   myDoc.H9 = myDoc.H9.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='HA')
                   {
                                   myDoc.HA = myDoc.HA.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='HB')
                   {
                                   myDoc.HB = myDoc.HB.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='HC')
                   {
                                   myDoc.HC = myDoc.HC.hex().toUpperCase();
                   }
                           else if (myDoc.hasOwnProperty(key) && key=='HM')
                   {
                                   myDoc.HM = myDoc.HM.hex().toUpperCase();
                   }
                }
                db.transactions_Bin_1day.insert(myDoc);
            }
        );
EOF




if [ -f /tmp/collection.js ]; then
        #cd /tmp
         /usr/bin/mongo  --host $mongo_db_host cardtronics --eval 'printjson(load("/tmp/collection.js"))' &> /tmp/abc
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                MSG=`cat /tmp/abc`
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  mongo  `hostname` get data from mongo status = $MSG" >>  $filename
                echo > /tmp/abc
                status_op_s=1
        else
                MSG=`cat /tmp/abc`
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  mongo `hostname` In get dat from mongo status = $MSG" >>  $filename
                echo > /tmp/abc
                error_op_s=1
                exit;
        fi
fi


#--------------------------
new=`date  "+%C%y-%m-%d %T"`
date_diff $old $new


#############STEP 6 ################
#-------------------------
old=`date  "+%C%y-%m-%d %T"`

echo "----------------Inserting data to Hive ORC table----------------------" >> $filename
cat > /tmp/hive.sh << EOF
hive -e "SET hive.exec.dynamic.partition = true; SET hive.exec.dynamic.partition.mode = nonstrict; use default; insert into table transactions_Bin_ORC PARTITION (SettlementDate) select InternalID ,OldID ,RecordInternalID ,ProcessorID ,Terminal ,TxnTypeID ,ResponseCodeID ,RejectCodeID ,BankID ,NetworkID ,TerminalSequenceNumber ,SettlementTime ,ActivityDate ,ActivityTime ,Amount ,Fee ,Surcharge ,Interchange ,Txn ,OurBank ,EBTTransaction ,LogID ,P_NetworkCode ,P_TxnCode ,P_ResponseCode ,P_RejectCode ,P_Field1 ,P_Field2 ,ATMInternalID ,EP ,InterchangeCalc ,International ,IchgRateID ,Branded ,DenyTxnType ,CardID ,DCCAmount ,DCCTotal ,DCCTXn ,Deny711 ,CountryCode ,HP4 ,HP5 ,HP6 ,HP7 ,HP8 ,HP9 ,HP10 ,HP11 ,HP12 ,HPCATM ,PAN,SettlementDate from transactions_Bin_link;";
EOF
        su - hdfs -c "/bin/bash /tmp/hive.sh" &> /tmp/abc
        #$HIVE_INS &> /tmp/abc
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                MSG=`cat /tmp/abc`
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  HIVE  `hostname` inserting data in Hive in  ORC format $MSG" >>  $filename
                echo > /tmp/abc
                status_op_s=1
        else
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  HIVE `hostname` inserting data in HIve in ORC format" >>  $filename
                error_op_s=1
                exit;
        fi

#--------------------------
new=`date  "+%C%y-%m-%d %T"`
date_diff $old $new

################### STEP 7 ##############
#-------------------------
old=`date  "+%C%y-%m-%d %T"`
echo "----------------Count on Hive data----------------------" >> $filename

#echo "hive -e use default; select count(*) from transactions_Bin_ORC where settlementdate =$hive_orc_date;"
hive -e "use default; select count(*) from transactions_Bin_ORC where settlementdate ='$hive_orc_date';" &> /tmp/abc
        RETVAL=$?
        if [ $RETVAL -eq 0 ]; then
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  Hive  `hostname` count data from hive" >>  $filename
                totalhadoop=`cat /tmp/abc | tail -n 2 | head -n 1`
                status_op_s=1
        else
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  Hive `hostname` count data from hive" >>  $filename
                error_op_s=1
                exit;
        fi

#--------------------------
new=`date  "+%C%y-%m-%d %T"`
date_diff $old $new

if [ $error_op_s -eq 1 ]; then
        echo "there is some error. Kindly check it or see logs"
fi

echo "totalmongo value is $totalmongo" >> $filename
echo "totalhadoop value is $totalhadoop" >> $filename
if [ $totalmongo -eq $totalhadoop ]; then
                ALEVEL="SUCCESS"
                echo "$now      $ALEVEL  SCRIPT  `hostname` Data import." >>  $filename
else
                ALEVEL="FAILURE"
                echo "$now      $ALEVEL  SCRIPT  `hostname` Data import." >>  $filename
fi

####--------------------------
new_c=`date  "+%C%y-%m-%d %T"`
date_diff $old_c $new_c

exit;
