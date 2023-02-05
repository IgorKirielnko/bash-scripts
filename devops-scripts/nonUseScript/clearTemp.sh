#!/usr/bin/env bash

WASHOME=/opt/IBM/WebSphere/AppServer
PROFILES=`ls -1 ${WASHOME}/profiles`

    echo "     Deleting temp files"
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/config/temp/*
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/temp/*
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/wstemp/*
	echo "     Deleting dump files"
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/core.*.dmp
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/heapdump.*.phd
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/javacore.*.txt
	rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/Snap.*.trc