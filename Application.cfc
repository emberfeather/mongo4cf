<cfcomponent output="false">
	<cfset this.name = 'mongo4cf' />
	<cfset this.applicationTimeout = createTimeSpan(0, 1, 0, 0) />
	<cfset this.clientManagement = false />
	<cfset this.sessionManagement = false />
	
	<!--- Set the mappings --->
	<cfset variables.mappingBase = getDirectoryFromPath( getCurrentTemplatePath() ) />
	
	<cfset this.mappings['/mongo4cf'] = variables.mappingBase & 'mongo4cf' />
	<cfset this.mappings['/test'] = variables.mappingBase & 'test' />
</cfcomponent>
