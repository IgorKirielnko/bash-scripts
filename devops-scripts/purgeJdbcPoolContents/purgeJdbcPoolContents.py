def getListArray(l):
	return l.splitlines()


listDS = getListArray(AdminControl.queryNames("*:type=DataSource,*"))
print list

for dataSource in listDS:
	print dataSource
	print "    showPoolContents:"
	print AdminControl.invoke(dataSource, "showPoolContents")
	try:
		print "    purgePoolContents:"
		print AdminControl.invoke(dataSource, "purgePoolContents", "immediate")
	except:
		print "    purgePoolContents FAIL"
	print "    END"
	