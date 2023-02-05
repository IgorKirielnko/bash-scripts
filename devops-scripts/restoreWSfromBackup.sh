date=`date +"%Y-%m-%d-%H-%M"`
echo "$date"
echo ""
echo "Restore WebSphere from backup $date"
backupdir="/opt/IBM/backup/WS"
mkdir -p -m 777 $backupdir
/opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh  -delete -profileName Dmgr01
/opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh  -validateAndUpdateRegistry 
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01
/opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh  -restoreProfile -backupFile $backupdir/Dmgr01.zip
/opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh  -validateAndUpdateRegistry 
grep 'ead-dev' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/ead-dev/ead-tst/g'
grep 'EAD-DEV' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells/DatacenterFNCell/nodes | xargs sed -i 's/EAD-DEV/EAD-TST/g'
grep 'GCDDB4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/GCDDB4/GCDDB5/g'
grep 'MADOC4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/MADOC4/MADOC5/g'
grep 'BDAD4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/BDAD4/BDAD5/g'
grep 'OSIN4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSIN4/OSIN5/g'
grep 'OSMI4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSMI4/OSMI5/g'
grep 'OADIT4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OADIT4/OADIT5/g'
grep 'OSSHOD4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSSHOD4/OSSHOD5/g'
grep 'OSTKP4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSTKP4/OSTKP5/g'
grep 'OSVE4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSVE4/OSVE5/g'
grep 'OSSYS4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/OSSYS4/OSSYS5/g'
grep 'DIRDB4' -R -I -l  /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells | xargs sed -i 's/DIRDB4/DIRDB5/g'
echo "Sync Nodes whit DMGR"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startServer.sh dmgr
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/syncNode.sh kis-exd-reload.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/syncNode.sh kis-exd-reload.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/syncNode.sh kis-exd-reload.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
echo "DONE"