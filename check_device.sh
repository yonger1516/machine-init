#!/bin/bash

NUM_CPU=72
NUM_MEM=264563512
NUM_DISK=8
LOGFILE=result.log
USER=yongfu
script_root=/home/yongfu/scripts
declare -A arr_disk

check_num(){
    echo "Checking $1...">>$LOGFILE
    if [ $2 -ne $3 ]
    then
         echo "Failed,expected:"$2" actual:"$3>>$LOGFILE
    fi
}

tear_done(){
    ssh $USER@$1 rm -f /tmp/test*
}


echo "">$LOGFILE

for i in {41..50}
do
    host=172.30.20.$i
    echo "Check HW setup info on "$host
    echo "Check HW setup info on "$host>>$LOGFILE
    cpus=`ssh $USER@$host cat /proc/cpuinfo|grep  processor|wc -l`

    check_num cpu $NUM_CPU $cpus

    memorys=`ssh $USER@$host cat /proc/meminfo|grep MemTotal|awk '{print $2}'`
    check_num memory $NUM_MEM $memorys

    ssh -t $USER@$host source $script_root/disk.sh>>$LOGFILE
    #ssh -t $USER@$host $script_root/network.sh $i >>$LOGFILE 2>&1
   
    echo "============================">>$LOGFILE
    
    
    tear_done $host
done

echo "Check done."

