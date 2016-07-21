#!/bin/bash
#temporarily work
echo 'never' |sudo tee /sys/kernel/mm/redhat_transparent_hugepage/defrag

#write to configuration file
 echo "echo never >/sys/kernel/mm/redhat_transparent_hugepage/defrag"|sudo tee --append /etc/rc.local
