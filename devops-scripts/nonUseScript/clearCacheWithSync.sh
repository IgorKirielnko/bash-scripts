date=`date +"%Y-%m-%d-%H-%M"`
echo "$date"
echo ""
echo "Stopping WebSphere"
echo ""
pkill -9 -f AppServer
echo ""
echo "Deleting cache AppSrv03"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/config/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/wstemp/*
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/core.*.dmp
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/heapdump.*.phd
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/javacore.*.txt
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv03/Snap.*.trc
echo ""
echo "Deleting cache AppSrv02"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/config/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/wstemp/*
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/core.*.dmp
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/heapdump.*.phd
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/javacore.*.txt
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv02/Snap.*.trc
echo ""
echo "Deleting cache AppSrv01"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/config/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/wstemp/*
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/core.*.dmp
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/heapdump.*.phd
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/javacore.*.txt
rm -f /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/Snap.*.trc
echo ""
echo "Deleting cache Dmgr01"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/wstemp/*
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/core.*.dmp
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/heapdump.*.phd
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/javacore.*.txt
rm -f /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/Snap.*.trc
echo ""
echo "Clear ClassCache and OSGi"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/clearClassCache.sh
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/osgiCfgInit.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/clearClassCache.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/osgiCfgInit.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/clearClassCache.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/osgiCfgInit.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/clearClassCache.sh
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/osgiCfgInit.sh
echo ""
echo "Start DMGR"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startServer.sh dmgr
echo ""
echo "Start Sync Nodes"
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/syncNode.sh UZDO-TST1.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/syncNode.sh UZDO-TST1.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/syncNode.sh UZDO-TST1.tn.fntst.ru 8879 -username wasadmin -password o9p0[-]=
echo ""
echo "Start NodeAgents"
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh nodeagent
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/startServer.sh nodeagent
echo ""
echo "Restart WebServer"
echo ""
/opt/IBM/HTTPServer/bin/apachectl stop
/opt/IBM/HTTPServer/bin/adminctl stop
sleep 5
/opt/IBM/HTTPServer/bin/apachectl start
/opt/IBM/HTTPServer/bin/adminctl start
date=`date +"%Y-%m-%d-%H-%M"`
echo ""
echo "$date"
echo "TASK COMPLEATE. Servers stop clear and sync with DMGR..."