for key in ['IBM_HEAPDUMPDIR', 'IBM_COREDIR', 'IBM_JAVACOREDIR']:
	name = ['name', key]
	value = ['value', '/workdir/WebSphere/AppSrv01']
	attrList = [name, value]
	srvid = AdminConfig.getid('/Node:CPE-NODE-01/Server:nodeagent')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()
	srvid = AdminConfig.getid('/Server:cpe-server-01')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()
	value = ['value', '/workdir/WebSphere/AppSrv02']
	attrList = [name, value]
	srvid = AdminConfig.getid('/Node:APP-NODE-01/Server:nodeagent')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()
	value = ['value', '/workdir/WebSphere/AppSrv03']
	attrList = [name, value]
	srvid = AdminConfig.getid('/Node:APP-NODE-02/Server:nodeagent')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()
	value = ['value', '/workdir/WebSphere/Dmgr01']
	attrList = [name, value]
	srvid = AdminConfig.getid('/Server:dmgr')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()
	value = ['value', '/workdir/WebSphere/']
	attrList = [name, value]
	srvid = AdminConfig.getid('/Server:app_cluster')
	pdef = AdminConfig.list('JavaProcessDef', srvid)
	AdminConfig.modify(pdef, [['environment', [attrList]]])
	AdminConfig.save()