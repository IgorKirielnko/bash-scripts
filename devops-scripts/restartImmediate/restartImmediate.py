import sys
serverName=sys.argv[0]
nodeName=sys.argv[1]
print '\nTerminating: server=%s node=%s \n' % (serverName,nodeName)
nodeAgentObj=AdminControl.completeObjectName('type=NodeAgent,node='+nodeName+',*')
print AdminControl.invoke(nodeAgentObj, 'terminate', '['+serverName+']', '[java.lang.String]')
AdminControl.startServer(serverName, nodeName)
