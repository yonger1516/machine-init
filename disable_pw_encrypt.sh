#!/bin/bash

sudo sed -i -e 's/KexAlgorithms diffie-hellman-group-exchange-sha256/#KexAlgorithms diffie-hellman-group-exchange-sha256/' /etc/ssh/sshd_config

sudo sed -i -e 's/Ciphers aes256-ctr,aes192-ctr,aes128-ctr/#Ciphers aes256-ctr,aes192-ctr,aes128-ctr/' /etc/ssh/sshd_config

sudo sed -i -e 's/MACs hmac-sha2-512,hmac-sha2-256,hmac-ripemd160/#MACs hmac-sha2-512,hmac-sha2-256,hmac-ripemd160/' /etc/ssh/sshd_config

sudo service sshd restart
