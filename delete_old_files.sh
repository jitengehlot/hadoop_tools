#!/bin/bash

#####################################################################
# Author: Jitendra Gehlot
# Filename: delete_old_files.sh
# Date: 10/08/2014
# Description: This script is used to clean the "Temp" folder 
#              for HIVE USERS where folders are older than 15 days.
#####################################################################

dir1="/tmp/hive-beeswax-jupton"
#dir2="/tmp/hive-beeswax-tupton"

totalsize_of_tmp=`sudo -u hdfs hdfs dfs -du  -h -s /tmp`

#big_dir=`sudo -u hdfs hdfs dfs -du -h /tmp | grep G`
#echo $totalsize_of_tmp;
#echo $big_dir;
su - hdfs -c "hdfs dfs -ls $dir1" > /tmp/dir1



cat > /tmp/c_time.sh <<EOF
#check date
date_a=\`date  +%Y-%m-%d  --date="15 days ago"\`

date_b=\`echo \$1 |awk -F"==" '{print \$1}'\`
file=\`echo \$1 | awk -F"==" '{print \$2}'\`

if [[ "\$date_a" > "\$date_b" ]] ;
then
#    echo "break"
        echo \$file;
#	sudo -u hdfs hdfs fs -rmr \$file
fi

EOF



for i in `cat /tmp/dir1 | awk '{print $6"=="$8}'`; do  /bin/bash /tmp/c_time.sh $i ; done


#check size
nowsize_is_tmp=`sudo -u hdfs hdfs dfs -du  -h -s /tmp`


#mail
echo "Total size was /tmp  $totalsize_of_tmp and now  $nowsize_is_tmp" | mail -s "Delete tmp files" email@example.com
