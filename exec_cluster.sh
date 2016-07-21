#!/bin/bash

USER=yongfu
home=/home/yongfu/scripts
cmd=$1

for i in {31..50}
do
    host=172.30.21.$i 
    echo "job running on "$host
    ssh -t $USER@$host source $home/$cmd $2

done

echo "done."
