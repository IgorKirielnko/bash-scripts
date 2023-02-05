#!/bin/bash

/opt/IBM/WebSphere/AppServer/profiles/APP/bin/stopServer.sh app_cluster_app-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/CPE/bin/stopServer.sh cpe_cluster_cpe-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/GATE/bin/stopServer.sh javagate_cluster_gate-node01 -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/IHS/bin/stopServer.sh ihs01 -user wsadmin -password PNTcs78Y
