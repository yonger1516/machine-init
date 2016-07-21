#!/bin/bash

sudo sysctl vm.swappiness=0
echo "vm.swappiness=0" |sudo tee --append /etc/sysctl.conf
