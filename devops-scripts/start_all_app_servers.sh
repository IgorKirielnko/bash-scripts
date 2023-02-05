#!/bin/bash

/opt/IBM/WebSphere/AppServer/profiles/APP/bin/startServer.sh app_cluster_app-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/CPE/bin/startServer.sh cpe_cluster_cpe-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/GATE/bin/startServer.sh javagate_cluster_gate-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/IHS/bin/startServer.sh ihs01 -user wsadmin -password PNTcs78Y
