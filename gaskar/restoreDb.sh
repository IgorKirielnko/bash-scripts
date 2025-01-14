#!/bin/bash

ID='74894d12860d'

find /data/postgresbackup/ -name "*gz"|cut -d '_' -f 3-|cut -d '.' -f 1 > /tmp/list_db
find /data/postgresbackup/ -name "*gz" > /tmp/list_backup





LineCountListDB=$(wc -l  /tmp/list_db|cut -c -2)


while [[ $LineCountListDB > 1 ]]
do
NameDB=$(sed -n 1p /tmp/list_db)
FileBackupGZ=$(sed -n 1p /tmp/list_backup)
gzip -d ${FileBackupGZ}
sed -i 1d /tmp/list_backup
FileBackupSQLhost=$(find /data/postgresbackup/ -maxdepth 1 -name "*sql")
FileBackupSQL=$(echo $FileBackupSQLhost|sed s:/data/postgresbackup/:/var/lib/postgresql/data/:g)


docker exec -it $ID psql -U admin -d postgres -c "DROP DATABASE ${NameDB};"
docker exec -it $ID psql -U admin -d postgres -c "CREATE DATABASE ${NameDB};"
docker exec -it $ID psql -U admin -d ${NameDB} -f ${FileBackupSQL}



sed -i 1d /tmp/list_db
LineCountListDB=$(wc -l  /tmp/list_db|cut -c -2)
rm -fr ${FileBackupSQLhost}
done


#
#
#
#
#
#
#docker cp -a /home/i.kirilenko/pg_dump $ID:/tmp
#
#
#
#line=$(find /tmp/pg_dump -type f|wc -l|cut -c -2)
#while [ $line -gt 0 ]
#do
#file=$(find /tmp/pg_dump -type f|sed -n 1p)
#db=$(echo $file|cut -d '/' -f 4- )
#docker exec -it $ID psql -U admin -d postgres -c "DROP DATABASE $db;"
##docker exec -it $ID psql -U admin -d $db -f $file
##docker exec -it $ID psql -U admin -d $db -f $file
##file=$(find /tmp/pg_dump -type f|sed -n 1p)
#line=$(find /tmp/pg_dump -type f|wc -l|cut -c -2)
#rm -fr $file
#done
#rm -fr /tmp/pg_dump
