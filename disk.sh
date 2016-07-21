#!/bin/bash

NUM_DISK=8
PASSWORD=TXPLvskusABDL29a
declare -A arr_disk

check_num(){
    echo "Checking # of $1..."
    if [ $2 -ne $3 ]
    then
         echo "Failed,expected:"$2" actual:"$3
    fi
}

get_disks(){
	#arr_disk=`ssh $USER@$host parted -l|grep -P "Disk /dev/[a-z]+: [0-9]+GB"|awk '{print    $2}'|awk -F":" '{print $1}'` 
	arr_disk=`find /dev -type b |grep -P "/dev/sd[a-z]$"`
}

read_disk(){
    #disable cache
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1

    speed=`echo $PASSWORD|sudo -S dd if=$1 of=/dev/null bs=1M count=10000|& awk '/copied/ {print $8 " "  $9}'`
    echo $1" read performance :"$speed

}


check_disk(){
    
    get_disks 

    #echo "# of disk:"${#arr_disk[*]}

    #echo "disk arr:"${arr_disk[*]}
    i=0
    for disk in ${arr_disk[*]}
    do
	let i+=1
        if [ $disk == "/dev/sda" ]
        then
	  
            speed=`echo $PASSWORD|sudo -S dd if=/dev/zero of=/tmp/test.bak bs=4k count=10000 conv=fsync|& awk '/copied/ {print $8 " "  $9}'`
            echo $disk" write performance :"$speed 
	    read_disk $disk

	else 
  	    speed=`echo $PASSWORD|sudo -S dd if=/dev/zero of=$disk bs=4k count=10000 conv=fsync|& awk  '/copied/ {print $8 " "  $9}'`
            #sleep 5
 	    echo $disk" write performance :"$speed

	    read_disk $disk
	fi 
   done
    #echo "# of disk:"$i
    check_num disk $NUM_DISK $i


}
check_disk


