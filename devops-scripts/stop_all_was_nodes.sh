#!/bin/bash

/opt/IBM/WebSphere/AppServer/profiles/APP/bin/stopNode.sh -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/CPE/bin/stopNode.sh -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/GATE/bin/stopNode.sh -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/IHS/bin/stopNode.sh -user wsadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/DMGR/bin/stopManager.sh -user wsadmin -password PNTcs78Y