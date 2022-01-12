#!/bin/bash
export PATH=$PATH:/opt/IBM/InstallationManager/eclipse/tools/
ls /mnt/nfs/kirilenko-test/|sed -r s:\ :\n:g|grep -v full > /tmp/ListRepo
line=$(wc -l /tmp/ListRepo|cut -c -2)
while [ $line -gt 0 ]
do 
repo=$(sed -n 1p /tmp/ListRepo)
imcl listAvailablepackages -repositories /mnt/nfs/kirilenko-test/$repo/repository.config > /tmp/ListPackages
echo $repo
linePackages=$(wc -l /tmp/ListPackages|cut -c -2)
	while [ $linePackages -gt 0 ]
	do
	packages=$(sed -n 1p /tmp/ListPackages) 
	imcl install $packages -repositories $repo/repository.config -acceptLicense -showProgress && echo $packages
	sed -i 1d /tmp/ListPackages
	linePackages=$(wc -l /tmp/ListPackages|cut -c -2)
	done 
sed '1d' -i /tmp/ListRepo
line=$(wc -l /tmp/ListRepo|cut -c -2)
done
