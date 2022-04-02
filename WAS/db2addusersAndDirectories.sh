#!/bin/bash
mkdir -p /db/DB
mkdir -p /db/alog
mkdir -p /db/mlog
groupadd db2iadm1
groupadd db2fadm1
groupadd dasadm1
useradd -G db2iadm1 -p o9p0[-]=  -u 2000 -m -d /home/db2inst1 db2inst1
useradd -G db2fadm1 -p o9p0[-]=  -u 2001 -m -d /home/db2fenc1 db2fenc1
useradd -G dasadm1 -p o9p0[-]=  -u 2002 -m -d /home/dasusr1 dasusr1
useradd -p o9p0[-]= -m cpeuser
useradd -p o9p0[-]= -m os0user
useradd -p o9p0[-]= -m os1user
useradd -p o9p0[-]= -m refuser
chown -R db2fenc1:db2fadm1 /home/db2fenc1
chown -R db2inst1:db2iadm1 /home/db2inst1
chown -R dasusr1:dasadm1 /home/dasusr1
./db2_install -b /opt/IBM/db2/V10.5/ -p SERVER -f NOTSAMP -f sysreq
## добавить окно, найти бд и установить, когда нашлась показать путь и переспросить
