#!/bin/bash

FILE='/tescan/files.txt'
logfile='/tescan/tescan.log'
minimumsize=350000
actualsize=$(wc -c <"$logfile")

date=$(date)
backupdate=$(date +%G%m%d%H%M)

if [ "$actualsize" -ge "$minimumsize" ] 
	then
#	echo "size is over $minimumsize bytes, actualsize is $actualsize"
	tar -czf "$logfile.$backupdate.gz" $logfile
	rm $logfile
#else
#	echo "size is under $minimumsize bytes, actualsize is $actualsize"
fi

while read LINE; do
	 podr=$(echo $LINE | cut -f 1 -d ' ')
	 city=$(echo $LINE | cut -f 2 -d ' ')
	 nam=$(echo $LINE | cut -f 3 -d ' ')
	 ipaddr=$(echo $LINE | cut -f 4 -d ' ')
	 if ping -c 1 $ipaddr &> /dev/null
	 then
	 	stat='связь есть'
	 else
		stat="СВЯЗИ НЕТ - IP: $ipaddr"
	 fi
	 
	 logstr="$date  Отдел: $podr, Город: $city, Узел: $nam, Сервер: $stat"

	echo $logstr 
	echo $logstr >> "$logfile"

done < $FILE
echo "*********************" >> "$logfile"

