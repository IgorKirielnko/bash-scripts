#!/bin/bash
#этот скрипт прописывать в кронтаб!!!!!#
#
#
#
mkdir -p /tmp/dump_save
find /home/satana/Documents/GZHI/New -maxdepth 1 -name "*.zip" >/tmp/dump_save/list-new-zip
export yyyy=$(sed -n 1p /tmp/dump_save/list-new-zip)
#тут не хватает логики, файловов может быть несколько
#echo $yyyy 
cp $yyyy /data/db/ -r


find /data/db/ -maxdepth 1 -name "*.zip" >/tmp/dump_save/db_files-zip
export yy=$(sed -n 1p /tmp/dump_save/db_files-zip) 
#тут тоже не хватает логики файлово может быть несколько.
#echo $yy

unzip -o $yy -d /data/db/database/ && sleep 1 && mv $yy /data/db/the_old_dump  

find /data/db/database -maxdepth 1 -name '*.doc'|sed 's/.doc//g'>/tmp/dump_save/list_dir
#sed -i 's/^/mkdir\ /g' /tmp/list_dir;
##sed -ri "s/....$"
#sed -ri "s/$/;/g" /tmp/list_dir;
#sed -ri "s/2020_.*/2020;/g" /tmp/list_dir;
#sed -ri "s/2021_.*/2021;/g" /tmp/list_dir;
#cat /tmp/list_dir|sort|uniq>/tmp/list;
#bash /tmp/list;
#ls -d */ | cut -f1 -d'/'>/tmp/dir1;
#cp /tmp/dir1 /tmp/dir2;
#sed -ri 's/$/;/g' /tmp/dir2;
#cat /tmp/dir{1..2}>/tmp/dir3
#cat /tmp/dir3|sort|uniq>/tmp/dir4
#sed -ri '1~2 s/^/mv\ /g' /tmp/dir4
#sed -ri '1~2 s/$/*/g' /tmp/dir4
#cat /tmp/dir4|tr '\n' ' '>/tmp/dir5
#bash /tmp/dir5 &>/dev/null &

#find /data/db/database -maxdepth 1 -name '*.log' >/tmp/log-gzhi-database
#export yyy=`sed -n 1p /tmp/log-gzhi-database`
#sleep 2
#mv $yyy /data/db/database/log

#sleep 2
#find /home/satana/Documents/GZHI/New -maxdepth 1 -name '*.zip' >/tmp/list-new-zip
#export yyyy=`sed -n 1p /tmp/list-new-zip`
#cp $yyyy /data/db/
#echo done!
#find /data/db/ -maxdepth 1 -name '*.zip' -exec rm -f {} \;


#mount_data=$(mount|grep data|grep '(ro')

#if [[ mount_data -z ]];
#then 
