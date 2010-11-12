<cfset directoryRunner = createObject('component', 'mxunit.runner.DirectoryTestSuite') />

<cfset results = directoryRunner.run(
	directory = expandPath('.'),
	recurse = true,
	componentPath = 'test'
) />

<cfoutput>#results.getResultsOutput()#</cfoutput>
