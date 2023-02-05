date=`date +"%Y-%m-%d-%H-%M"`
echo "$date"
echo ""
echo "Stopping WebSphere"
echo ""
echo "Stopping wpxt_cluster_was-wpxt-node02"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/stopServer.sh nodeagent -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/stopServer.sh wpxt_cluster_was-wpxt-node02 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping wpxt_cluster_was-wpxt-node01"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/stopServer.sh nodeagent -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/stopServer.sh wpxt_cluster_was-wpxt-node01 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping javagate_cluster_was-wpxt-node02"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/stopServer.sh javagate_cluster_was-wpxt-node02 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping javagate_cluster_was-wpxt-node01"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/stopServer.sh javagate_cluster_was-wpxt-node01 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping uzdo_cluster_was-wpxt-node02"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv03/bin/stopServer.sh uzdo_cluster_was-wpxt-node02 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping uzdo_cluster_was-wpxt-node01"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/bin/stopServer.sh uzdo_cluster_was-wpxt-node01 -user wsadmin -password PNTcs78Y
echo ""
echo "Stopping cpe_node01"
echo ""
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh nodeagent -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh server1 -user wsadmin -password PNTcs78Y
echo "Stopping dmgr"
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/stopServer.sh dmgr -user wsadmin -password PNTcs78Y
appserver=`pgrep -f AppServer`
i=30
while [ "$appserver" != "" -a "$i" -ne "0" ]
	do
		i=`expr  $i - 1`
		sleep 1
		appserver=`pgrep -f AppServer`
		echo "$isec waiting"
		echo "Process:"
		echo $appserver
	done
if  [ "$appserver" != "" ]
	then
		echo "Process still runnung"
		echo "Killing process"
		pgrep -f AppServer
		pkill -9 -f AppServer
		echo "Process stoped HARD"
	else
		echo "Process stoped normal"
fi
echo ""
echo "Deleting cache /tmp"
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
date=`date +"%Y-%m-%d-%H-%M"`
echo ""
echo "$date"
echo "CLEAR CACHE COMPLEATE."
