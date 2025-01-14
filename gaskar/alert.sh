#!/bin/bash

STAND=("suid" "dev-vis" "dev-gis" "demo" "stage-vis" "stage-gis" "suid-preprod")

for NameStand in ${STAND[@]};
do
echo $NameStand
date=$(date +%Y.%m.%d)
source /home/i.kirilenko/credentials/$NameStand/backup.cfg
docker run --name pgsql -it nexus.aniklab.com:444/postgres:latest bash -c "psql postgresql://${POSTGRES_ROOT_USERNAME}:${POSTGRES_ROOT_PASSWORD}@${POSTGRES_HOST}/postgres -c 'SELECT datname FROM pg_database' > /tmp/list_db"; docker cp pgsql:/tmp/list_db /home/i.kirilenko/;docker rm -f pgsql;

sed '$d' -i /home/i.kirilenko/list_db
sed '$d' -i /home/i.kirilenko/list_db
sed '1,2d' -i /home/i.kirilenko/list_db
sed 's/\ //g' -i /home/i.kirilenko/list_db
sed '/template1/d' -i /home/i.kirilenko/list_db
sed '/template0/d' -i /home/i.kirilenko/list_db
sort /home/i.kirilenko/list_db -o /home/i.kirilenko/list_db
find /r6-storage/archive/$NameStand/ -name "${date}*.gz"|cut -d '_' -f 3-|cut -d '.' -f -1|sort|tr -d ' ' > /home/i.kirilenko/list_backup
sort /home/i.kirilenko/list_backup -o /home/i.kirilenko/list_backup
a=$(diff /home/i.kirilenko/list_db /home/i.kirilenko/list_backup|grep '<'|sed 's/<//g')

find /r6-storage/archive/${NameStand}/ -name "${date}*.gz" > /home/i.kirilenko/list_db_line
line=$(wc -l /home/i.kirilenko/list_db_line|cut -b -2)

while [[ $line > 1 ]]
do
string=$(sed -n 1p /home/i.kirilenko/list_db_line)
countline=$(zcat ${string}|wc -l|cut -b -3)

if [ $countline -lt 50 ]
then
namedb=$(echo $string|cut -d '_' -f -4)
MESSAGE="Backup:${namedb} содержит меньше 50 строк.";
CHAT_ID="-1002090311909"
#CHAT_ID="-4609910140";
API_TOKEN="5015429533:AAFqYz442D8TO7ULtSTTbAAaQYNZEHeHXzc";
curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" 1>/dev/null
fi

sed -i 1d /home/i.kirilenko/list_db_line
line=$(wc -l /home/i.kirilenko/list_db_line|cut -b -2)
done

listdb=$(diff /home/i.kirilenko/list_db /home/i.kirilenko/list_backup|wc -l)

if [ $listdb -ne 0 ]
then
MESSAGE="Не обнаружены backup db:${a} из ${NameStand} за ${date}";
CHAT_ID="-1002090311909";
#CHAT_ID="-4609910140";
API_TOKEN="5015429533:AAFqYz442D8TO7ULtSTTbAAaQYNZEHeHXzc";
curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" 1>/dev/null
fi

rm -fr /home/i.kirilenko/list_backup
rm -rf /home/i.kirilenko/list_db
done
