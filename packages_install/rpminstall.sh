#/bin/bash
ls /root/*.rpm > /run/PackagesList
line=$(wc -l /run/PackagesList|cut -c -2)
while [ $line != 0 ] 
do
packag=$(sed -n 1p /run/PackagesList)
rpm -ivh --force $packag
sed 1d -i /run/PackagesList
line=$(wc -l /run/PackagesList|cut -c -2)
done
