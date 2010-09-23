component {
	public component function init() {
		variables.useJavaloader = !structKeyExists(server, 'railo');
		
		if(variables.useJavaloader) {
			variables.javaloader = createObject('component','javaloader.javaloader').init([ expandPath('/mongo4cf/lib/mongo.jar') ]);
		}
		
		return this;
	}
	
	public any function getJavaObject( required string definition ) {
		if(variables.useJavaloader) {
			return variables.javaloader.create( arguments.definition );
		}
		
		return createObject('java', arguments.definition, '/mongo4cf/lib/mongo.jar');
	}
}
