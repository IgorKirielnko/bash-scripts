#!/bin/bash
yum install argus-agent.x86_64 -y && chkconfig --add argus-agentd && chkconfig --level 3 argus-agentd on
sed '80 s:Server=.*:Server=000.000.000.000:' -i /etc/argus/argus_agentd.conf
service argus-agentd restart && ip a|grep inet
