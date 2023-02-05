mqcfList = AdminConfig.list('MQConnectionFactory', AdminConfig.getid( '/Cell:DatacenterFNCell/')) 
print mqcfList

for mqcf in mqcfList.splitlines():
	mqcfName=AdminConfig.showAttribute (mqcf, 'name')
	print mqcfName
	AdminConfig.modify(mqcf, '[[connectionPool [[connectionTimeout 180] [maxConnections 10] [unusedTimeout 110] [minConnections 0] [agedTimeout 0] [purgePolicy EntirePool] [reapTime 30]]]]')
	AdminConfig.modify(mqcf, '[[sessionPool [[connectionTimeout 180] [maxConnections 10] [unusedTimeout 110] [minConnections 0] [agedTimeout 0] [purgePolicy EntirePool] [reapTime 30]]]]')
	AdminConfig.save()
	
mqqcfList = AdminConfig.list('MQQueueConnectionFactory', AdminConfig.getid( '/Cell:DatacenterFNCell/')) 
print mqqcfList

for mqqcf in mqqcfList.splitlines():
	mqqcfName=AdminConfig.showAttribute (mqqcf, 'name')
	print mqqcfName
	AdminConfig.modify(mqqcf, '[[connectionPool [[connectionTimeout 180] [maxConnections 10] [unusedTimeout 110] [minConnections 0] [agedTimeout 0] [purgePolicy EntirePool] [reapTime 30]]]]')
	AdminConfig.modify(mqqcf, '[[sessionPool [[connectionTimeout 180] [maxConnections 10] [unusedTimeout 110] [minConnections 0] [agedTimeout 0] [purgePolicy EntirePool] [reapTime 30]]]]')
	AdminConfig.save()