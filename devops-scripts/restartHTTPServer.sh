exec "/opt/IBM/HTTPServer/bin/apachectl" "stop"
exec "/opt/IBM/HTTPServer/bin/adminctl" "stop"
sleep 5s
exec "/opt/IBM/HTTPServer/bin/apachectl" "start"
exec "/opt/IBM/HTTPServer/bin/adminctl" "start"