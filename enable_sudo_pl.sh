#!/bin/bash
password=8400530bwm
echo $password|sudo -S sed -i -e "s/yongfu.*/yongfu ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers
