profiles="Dmgr01 AppSrv01 AppSrv02 AppSrv03"
newHome="/workdir/WebSphere"
echo "Stopping WebSphere"
pkill -9 -f AppServer
for profile in $profiles; do
	echo "Deleting cache on $profile"
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/$profile/config/temp
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/$profile/temp
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/$profile/wstemp
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/$profile/logs
	rm -f /opt/IBM/WebSphere/AppServer/profiles/$profile/core.*.dmp
	rm -f /opt/IBM/WebSphere/AppServer/profiles/$profile/heapdump.*.phd
	rm -f /opt/IBM/WebSphere/AppServer/profiles/$profile/javacore.*.txt
	rm -f /opt/IBM/WebSphere/AppServer/profiles/$profile/Snap.*.trc
	echo "Clear ClassCache and OSGi on $profile"
	/opt/IBM/WebSphere/AppServer/profiles/$profile/bin/clearClassCache.sh
	/opt/IBM/WebSphere/AppServer/profiles/$profile/bin/osgiCfgInit.sh
	echo "Create symbolikLinks for $profile"
	mkdir -p $newHome/$profile/config/temp
	ln -s $newHome/$profile/config/temp /opt/IBM/WebSphere/AppServer/profiles/$profile/config/temp
	mkdir -p $newHome/$profile/temp
	ln -s $newHome/$profile/temp /opt/IBM/WebSphere/AppServer/profiles/$profile/temp
	mkdir -p $newHome/$profile/wstemp
	ln -s $newHome/$profile/wstemp /opt/IBM/WebSphere/AppServer/profiles/$profile/wstemp
	mkdir -p $newHome/$profile/logs
	ln -s $newHome/$profile/logs /opt/IBM/WebSphere/AppServer/profiles/$profile/logs
done
echo "Move FileNets folder"
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/FileNet
mkdir -p $newHome/AppSrv01/FileNet
ln -s $newHome/AppSrv01/FileNet /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/FileNet