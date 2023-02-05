SCRIPTDIR=`dirname $0` 
/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/wsadmin.sh -conntype NONE -lang jython -f "$SCRIPTDIR/appsVersionsList.py" "$SCRIPTDIR/versions"
