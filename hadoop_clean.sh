#! /bin/bash

ambari-server stop
echo 'Ambari-Server stopped successfully'

ambari-agent stop
echo 'Ambari-Agent stopped successfully'

yum -y remove `yum list installed | grep -i hadoop | cut -d. -f1 | sed -e :a -e ‘$!N; s/\n/ /; ta’`
echo 'Hadoop components removed successfully'

yum -y remove ambari*
echo 'Ambari components removed successfully'

yum -y remove `yum list installed | grep -w ‘HDP’ | cut -d. -f1 | grep -v “^[ ]” | sed -e :a -e ‘$!N; s/\n/ /; ta’`
echo 'HDP components removed successfully'

yum -y remove `yum list installed | egrep -w ‘hcatalog|hive|hbase|zookeeper|oozie|pig|sqoop|snappy|hadoop-lzo|knox|hadoop|hue’ | cut -d. -f1 | grep -v “^[ ]” | sed -e :a -e ‘$!N; s/\n/ /; ta’` 

echo 'Hadoop ecosystem components removed successfully'

yum remove hive\*
yum remove oozie\*
yum remove pig\*
yum remove zookeeper\*
yum remove tez\*
yum remove hbase\*
yum remove ranger\*
yum remove knox\*
yum remove ranger\*
yum remove storm\*
yum remove hadoop\*
yum remove hadoop\*
yum erase ambari-server
yum erase ambari-agent
rm -rf /etc/yum.repos.d/ambari.repo /etc/yum.repos.d/HDP*
yum clean all
rm -rf /var/log/ambari-metrics-monitor
rm -rf /var/log/hadoop
rm -rf /var/log/hbase
rm -rf /var/log/hadoop-yarn
rm -rf /var/log/hadoop-mapreduce
rm -rf /var/log/hive
rm -rf /var/log/oozie
rm -rf /var/log/zookeeper
rm -rf /var/log/flume
rm -rf /var/log/hive-hcatalog
rm -rf /var/log/falcon
rm -rf /var/log/knox
rm -rf /var/lib/hive
rm -rf /var/lib/oozie
rm -rf /usr/hdp
rm -rf /usr/bin/hadoop
rm -rf /tmp/hadoop
rm -rf /var/hadoop
rm -rf /hadoop/*
rm -rf /local/opt/hadoop
rm -rf /etc/hadoop
rm -rf /etc/hbase
rm -rf /etc/oozie
rm -rf /etc/phoenix
rm -rf /etc/hive
rm -rf /etc/zookeeper
rm -rf /etc/flume
rm -rf /etc/hive-hcatalog
rm -rf /etc/tez
rm -rf /etc/falcon
rm -rf /etc/knox
rm -rf /etc/hive-webhcat
rm -rf /etc/mahout
rm -rf /etc/pig
rm -rf /etc/hadoop-httpfs
rm -rf /var/run/hadoop
rm -rf /var/run/hbase
rm -rf /var/run/hadoop-yarn
rm -rf /var/run/hadoop-mapreduce
rm -rf /var/run/hive
rm -rf /var/run/oozie
rm -rf /var/run/zookeeper
rm -rf /var/run/flume
rm -rf /var/run/hive-hcatalog
rm -rf /var/run/falcon
rm -rf /var/run/webhcat
rm -rf /var/run/knox 
rm -rf /local/home/zookeeper/* 
rm -rf /usr/lib/flume
rm -rf /usr/lib/storm
rm -rf /var/lib/hadoop-hdfs
rm -rf /var/lib/hadoop-yarn
rm -rf /var/lib/hadoop-mapreduce
rm -rf /var/lib/flume
rm -rf /var/lib/knox
rm -rf /var/tmp/oozie

echo '!!! Uninstalling Hadoop completely successfully !!!'
