date +"%Y-%m-%d-%H-%M"
WASHOME=/opt/IBM/WebSphere/AppServer
WASADMIN="wsadmin"
WASPASS="PNTcs78Y"
PROFILES=`ls -1 ${WASHOME}/profiles`
TIMEOUT=30
STARTLIST=""
STOPLIST=""
SYNC=1
START=1
STOP=0
FORCE=0
if [ $# -gt 0 ]; then
	for arg in $@; do
		case ${arg} in
			"-sync") SYNC=1
			;;
			"-start") START=1
			;;
			"-stop") STOP=1
			;;
			"-force") FORCE=1
			;;
			*)
			echo "Allowed arguments: 
-start - for start servers after clear cache (by default)
-stop - for stop servers after clear cache
-sync - for sync nodes after clear cache
-force - force stop by kill -9"
exit 1
			;;
		esac
	done
fi
for PROFILE in ${PROFILES}; do
	echo "Begin clear cache process for profile ${PROFILE}"
	SERVERS=`ls -1 ${WASHOME}/profiles/${PROFILE}/servers`
	for SERVER in ${SERVERS}; do
		echo "     Stopping server ${SERVER}"
		if [ ${FORCE} -eq 0 ]; then
			${WASHOME}/profiles/${PROFILE}/bin/stopServer.sh ${SERVER} -user ${WASADMIN} -password ${WASPASS} -timeout ${TIMEOUT}
		else
			echo "     FORCE"
			kill -9 `cat ${WASHOME}/profiles/${PROFILE}/logs/${SERVER}/${SERVER}.pid`
		fi	
		if [ ${SERVER} = 'nodeagent' ]; then
			if [ "${SYNC}" -eq 1 ]; then
				STARTLIST="${STARTLIST} ; ${WASHOME}/profiles/${PROFILE}/bin/syncNode.sh localhost 8879 -user ${WASADMIN} -password ${WASPASS}"
			fi
			if [ "${START}" -eq 1 ] && [ "${STOP}" -eq 0 ]; then
			STARTLIST="${STARTLIST} ; ${WASHOME}/profiles/${PROFILE}/bin/startServer.sh ${SERVER}"
			fi
		fi
		if [ ${SERVER} = 'dmgr' ]; then
			if [ "${SYNC}" -eq 1 ] || [ "${START}" -eq 1 ]; then
			STARTLIST="${WASHOME}/profiles/${PROFILE}/bin/startServer.sh ${SERVER} ${STARTLIST}"
			fi
			if [ "${SYNC}" -eq 1 ] && [ "${STOP}" -eq 1 ]; then
			STOPLIST="${WASHOME}/profiles/${PROFILE}/bin/stopServer.sh ${SERVER} -user ${WASADMIN} -password ${WASPASS} -timeout ${TIMEOUT}"
			fi
		fi
	done
	sleep 1
	APPSERVER_PIDS=`pgrep -f ${WASHOME}/profiles/${PROFILE}`
	KILL_TIMEOUT=${TIMEOUT}
	while [ "${APPSERVER_PIDS}" != "" ] && [ "${KILL_TIMEOUT}" -ne "0" ]
		do
			KILL_TIMEOUT=`expr  ${KILL_TIMEOUT} - 1`
			APPSERVER_PIDS=`pgrep -f ${WASHOME}/profiles/${PROFILE}`
			echo "     ${KILL_TIMEOUT} sec waiting for processes:"
			echo "     ${APPSERVER_PIDS}"
			sleep 1
		done
	if  [ "${APPSERVER_PIDS}" != "" ]
		then
			echo "     Processes still running. Kill it!"
			pkill -9 -f ${WASHOME}/profiles/${PROFILE}
			echo "     Processes stoped HARD"
		else
			echo "     Processes stoped normal"
	fi
	echo "     Deleting temp files"
	rm -rf ${WASHOME}/profiles/${PROFILE}/config/temp/*
	rm -rf ${WASHOME}/profiles/${PROFILE}/temp/*
	rm -rf ${WASHOME}/profiles/${PROFILE}/wstemp/*
	echo "     Deleting dump files"
	rm -rf ${WASHOME}/profiles/${PROFILE}/core.*.dmp
	rm -rf ${WASHOME}/profiles/${PROFILE}/heapdump.*.phd
	rm -rf ${WASHOME}/profiles/${PROFILE}/javacore.*.txt
	rm -rf ${WASHOME}/profiles/${PROFILE}/Snap.*.trc
	echo "     ClearClassCache"
	${WASHOME}/profiles/${PROFILE}/bin/clearClassCache.sh
	echo "     OsgiCfgInit"
	${WASHOME}/profiles/${PROFILE}/bin/osgiCfgInit.sh
	echo "     ${PROFILE}: DONE."
done
echo "Stopping http-server"
/opt/IBM/HTTPServer/bin/apachectl stop
/opt/IBM/HTTPServer/bin/adminctl stop
if [ "${START}" -eq 1 ] && [ "${STOP}" -eq 0 ]; then
STARTLIST="${STARTLIST} ; /opt/IBM/HTTPServer/bin/adminctl start; /opt/IBM/HTTPServer/bin/apachectl start;"
fi
echo "Starting servers"
echo ${STARTLIST}
eval "${STARTLIST}"
echo ${STOPLIST}
eval "${STOPLIST}"
date +"%Y-%m-%d-%H-%M"
echo "CLEAR CACHE COMPLEATE."