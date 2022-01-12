#!/bin/bash
cp /root/packages_installed /tmp/packages_installed
line=$(wc -l /tmp/packages_installed|cut -c -2)
while [ $line -gt 0 ]
do
package=$(sed -n 1p /tmp/packages_installed)
yum install -y $package
sed -i 1d /tmp/packages_installed
line=$(wc -l /tmp/packages_installed|cut -c -2)
done
