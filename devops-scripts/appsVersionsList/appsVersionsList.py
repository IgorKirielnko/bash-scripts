import string
from java.lang import String

def getAppModuleVersion(appName):
    version = AdminApp.view(appName, '-ModuleBuildID')
    return version

def getAppsVersionsList(path):
    appsString = AdminApp.list()
    appList = AdminUtilities.convertToList(appsString)
    appVersions = ""
    # Print apps and their version
    for appName in appList:
        appVersion = AdminApp.view(appName, '-buildVersion')
        startIndexVersion = appVersion.rfind(':') + 3
        endIndexVersion = len(appVersion)
        version =  appVersion[startIndexVersion:endIndexVersion]
		# if version is unknown - try get Build ID
        if version == 'Unknown':
            buildIDString = getAppModuleVersion(appName)
            BuildID = 'Unknown'
            buildIDList = AdminUtilities.convertToList(buildIDString)
            i = 0
            for y in buildIDList:
                startIndexBuildID = y.find('Build ID:  ')
                if startIndexBuildID > -1:
                    endIndexBuildID = len(y)
                    buildID = y[startIndexBuildID + 11:endIndexBuildID]
                    if buildID:
                        version = buildID
        appVersions = appVersions + appName.ljust(24) + ' ' + version + '\n'
    file = open(path, "w")
    file.write(appVersions)
    file.close()

getAppsVersionsList(sys.argv[0])
