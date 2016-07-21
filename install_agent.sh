#!/bin/bash

package_folder=/home/yongfu/packages/cloudera

case $1 in
    install)
	#clean repository if exist
	sudo rm -f /etc/yum.repos.d/cloudera*
	#install jdk at first
	sudo yum install -y $package_folder/oracle-j2sdk1.7-1.7.0+update67-1.x86_64.rpm

	sudo cp /home/yongfu/scripts/jdk1.7.sh /etc/profile.d/

	#install agent 
	sudo  yum --nogpgcheck localinstall -y $package_folder/cloudera-manager-daemons-5.4.3-1.cm543.p0.258.el6.x86_64.rpm

	sudo  yum --nogpgcheck localinstall -y $package_folder/cloudera-manager-agent-5.4.3-1.cm543.p0.258.el6.x86_64.rpm

	#replace cloudera administrator console host 
	sudo sed -i -e "s/^server_host.*/server_host=10.30.21.41/" /etc/cloudera-scm-agent/config.ini

	eth2_ip=`sudo /sbin/ifconfig|grep 10.30.* |awk '{print $2}'|awk -F":" '{print $2}'`
	sudo sed -i -e "s/# listening_ip.*/listening_ip=$eth2_ip/" /etc/cloudera-scm-agent/config.ini

	host_name=`grep $eth2_ip /etc/hosts|awk '{print $2}'`
	sudo sed -i -e "s/# reported_hostname.*/reported_hostname=$host_name/" /etc/cloudera-scm-agent/config.ini
	#sudo sed -i -e "s/reported_hostname.*/reported_hostname=$host_name/" /etc/cloudera-scm-agent/config.ini
	;;
    start)
	#start agent
	sudo service cloudera-scm-agent restart
	;;
    stop)
	sudo service cloudera-scm-agent stop
	;;
    remove)
	sudo yum remove -y cloudera-manager-agent.x86_64
	sudo yum remove -y cloudera-manager-daemons.x86_64
	;;
    *)
esac


