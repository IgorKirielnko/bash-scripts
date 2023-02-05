#!/bin/bash

/opt/IBM/WebSphere/AppServer/profiles/CPE/bin/addNode.sh 127.0.0.1 8879 -profileName CPE -username wasadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/APP/bin/addNode.sh 127.0.0.1 8879 -profileName APP -username wasadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/GATE/bin/addNode.sh 127.0.0.1 8879 -profileName GATE -username wasadmin -password PNTcs78Y
/opt/IBM/WebSphere/AppServer/profiles/IHS/bin/addNode.sh 127.0.0.1 8879 -profileName IHS -username wasadmin -password PNTcs78Y
