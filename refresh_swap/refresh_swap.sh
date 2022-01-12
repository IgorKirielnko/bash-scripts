#!/bin/bash 
swapon -s
blkid|grep swap >/tmp/file
grep -E --only-matching "UUID=.{40}" /tmp/file >/tmp/file_1
sed -e 's:UUID=:: ; s:T$::' /tmp/file_1|tr -d "\"" > /tmp/file_2
line=$(wc -l /tmp/file_2|tr -d [:alpha:]|tr -d '\/')
while [ $line -gt 1 ]
do
print_line=$(sed -n 1p /tmp/fileee)
swapon -U $print_line 2>1&
sed 1d -i /tmp/file_2
line=$(wc -l /tmp/file_2|tr -d [:alpha:]|tr -d '\/')
done
free -g
