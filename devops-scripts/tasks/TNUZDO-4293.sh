#!/bin/bash

lastdate_str=`grep "Запуск получения документов" /workdir/logs/UZDO2-integrationnode1.log | \
    tail -n 1 | \
    awk '{print $1 " " $2}' | \
    sed -r 's/^(.*)\.(.*)\.(.*)\s(.*)$/20\3-\2-\1 \4/'`
echo $lastdate_str

lastdate=`date +'%s' -d "$lastdate_str"`
echo "lastdate: $lastdate"

current=`date +'%s'`
echo "current : $current"
