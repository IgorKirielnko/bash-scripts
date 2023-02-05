echo "Restart http-server"
/opt/IBM/HTTPServer/bin/apachectl stop
/opt/IBM/HTTPServer/bin/adminctl stop
sleep 5
/opt/IBM/HTTPServer/bin/adminctl start
/opt/IBM/HTTPServer/bin/apachectl start
