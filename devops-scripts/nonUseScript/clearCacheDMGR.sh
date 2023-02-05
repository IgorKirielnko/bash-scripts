date=`date +"%Y-%m-%d-%H-%M"`
echo "$date"
echo ""
echo "Stopping dmgr"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/stopServer.sh dmgr -user wasadmin -password o9p0[-]=
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
echo ""
echo "Starting WebSphere"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startServer.sh dmgr
echo ""
date=`date +"%Y-%m-%d-%H-%M"`
echo ""
echo "$date"
echo "CLEAR CACHE COMPLEATE. Servers will be available soon..."
