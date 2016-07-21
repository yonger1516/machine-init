#!/bin/bash

#PASSWORD=8400530bwm
server_ip=10.30.21.41

root_dir=/home/yongfu/packages
install_perf(){
    sudo rpm -i $root_dir/iperf-2.0.4-1.el6.rf.x86_64.rpm
}

check_interface_perf(){
    
    host_ip=10.30.21.$1
    if [ $host_ip = $server_ip  ]
    then 
	echo "server start..."
        iperf -s -B $server_ip &
    else 
        speed=` iperf -c $server_ip| grep Gbits/sec|awk '{print $(NF-1)}'`
        echo "Inteface with IP $bind_ip throughput:$speed Gbit/sec"
    fi


}

if [ x`command -v iperf` = x ]
then 
    install_perf
fi
check_interface_perf $1


