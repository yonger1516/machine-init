#!/bin/bash

 sudo sed -i -e "s/<\/configuration>/\n  <property>\n    <name>mapreduce.shuffle.max.threads<\/name>\n    <value>200<\/value>\n  <\/property>\n<\/configuration>/" /etc/hadoop/conf.cloudera.yarn/mapred-site.xml
