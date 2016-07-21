#!/bin/bash

app_id=$1
start_pattern="Storing application with id "$app_id
end_pattern="appId="$app_id".*finalStatus=SUCCEEDED"

yarnlog_dir=/var/log/hadoop-yarn/

start_time=`find $yarnlog_dir -maxdepth 1 -name hadoop-*RESOURCEMANAGER*out* |xargs grep -h "$start_pattern"|awk '{print $1,$2}'`

echo "Start time:"$start_time
attempt_app_id=""

if [[ $app_id == application* ]]
then 
    attempt_app_id="appattempt_"`echo $app_id|awk -F"_" '{print $2"_"$3}'`
fi

#echo $attempt_app_id

register_pattern="AM registration "$attempt_app_id
register_time=`find $yarnlog_dir -maxdepth 1 -name hadoop-*RESOURCEMANAGER*out* |xargs grep -h "$register_pattern"|awk '{print $1,$2}'`

echo "Register time:"$register_time

end_time=`find $yarnlog_dir -maxdepth 1 -name hadoop-*RESOURCEMANAGER*out* |xargs grep -hP "$end_pattern"|awk '{print $1,$2}'`
echo "End time:"$end_time

#export logs into file
find $yarnlog_dir -maxdepth 1 -name hadoop-*RESOURCEMANAGER*out* |xargs awk -v s_time="$start_time" -v e_time="$end_time" '{curr_time=$1" "$2;if(curr_time>=s_time&&curr_time<=e_time)print $0}' >>$app_id".log"
