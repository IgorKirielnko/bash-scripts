date=`date +"%Y-%m-%d-%H-%M"`
echo "$date"
echo ""
echo "Backup WebSphere $date"
backupdir=/mnt/backup/TST-215/tmp_$date
echo $backupdir
mkdir -p -m 777 $backupdir/WS
echo ""
echo "Stopping WebSphere"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/stopServer.sh dmgr -user wasadmin -password o9p0[-]=
echo ""
echo "Deleting cache Dmgr01"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/temp
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/temp
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/wstemp
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/core.*.dmp
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/heapdump.*.phd
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/javacore.*.txt
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/Snap.*.trc
echo ""
echo "Clear ClassCache and OSGi"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/clearClassCache.sh
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/osgiCfgInit.sh
echo ""
echo "BackUpping Dmgr01"
/opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh  -backupProfile -profileName Dmgr01  -backupFile $backupdir/WS/Dmgr01.zip
date=`date +"%Y-%m-%d-%H-%M"`
echo ""
echo "Copy staff"
cp -r /it $backupdir
cp -r /opt/IBM/FileNet/Config/WebClient $backupdir
echo ""
echo "Backup WebSphere complite $date"
echo ""
echo "Starting WebSphere"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startServer.sh dmgr
date=`date +"%Y-%m-%d-%H-%M"`
echo ""
echo "$date"
echo "BACKUP COMPLITE. Servers will be available soon..."