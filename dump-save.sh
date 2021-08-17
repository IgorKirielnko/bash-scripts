#!/bin/bash
#этот скрипт прописывать в кронтаб!!!!!#
#
#
#
find /home/paladin/Documents/GZHI/New -maxdepth 1 -name '*.zip' >/tmp/list-new-zip
export yyyy=`sed -n 1p /tmp/list-new-zip`
cp $yyyy /data/db/ -r


find /data/db/ -maxdepth 1 -name '*.zip' >/tmp/files-zip
sed -n 1p /tmp/files-zip >/tmp/file-list-zip-1
export yy=`cat /tmp/file-list-zip-1`
echo $yy
unzip -o $yy -d /data/db/database/ 
sleep 2
mv $yy /data/db/the_old_dump  
sleep 2
cd /data/db/database
find . -maxdepth 1 -name '*.doc'|sed 's/.doc//g'>/tmp/list_dir;
sed -i 's/^/mkdir\ /g' /tmp/list_dir;
#sed -ri "s/....$
sed -ri "s/$/;/g" /tmp/list_dir;
sed -ri "s/2020_.*/2020;/g" /tmp/list_dir;
sed -ri "s/2021_.*/2021;/g" /tmp/list_dir;
cat /tmp/list_dir|sort|uniq>/tmp/list;
bash /tmp/list;
ls -d */ | cut -f1 -d'/'>/tmp/dir1;
cp /tmp/dir1 /tmp/dir2;
sed -ri 's/$/;/g' /tmp/dir2;
cat /tmp/dir{1..2}>/tmp/dir3
cat /tmp/dir3|sort|uniq>/tmp/dir4
sed -ri '1~2 s/^/mv\ /g' /tmp/dir4
sed -ri '1~2 s/$/*/g' /tmp/dir4
cat /tmp/dir4|tr '\n' ' '>/tmp/dir5
bash /tmp/dir5 &>/dev/null &

find /data/db/database -maxdepth 1 -name '*.log' >/tmp/log-gzhi-database
export yyy=`sed -n 1p /tmp/log-gzhi-database`
sleep 2
mv $yyy /data/db/database/log




#sleep 2
#find /home/paladin/Documents/GZHI/New -maxdepth 1 -name '*.zip' >/tmp/list-new-zip
#export yyyy=`sed -n 1p /tmp/list-new-zip`
#cp $yyyy /data/db/
#echo done!
#find /data/db/ -maxdepth 1 -name '*.zip' -exec rm -f {} \;

