#!/bin/bash

cat /home/yongfu/scripts/id_rsa.pub |sudo tee --append /root/.ssh/authorized_keys
