component {
	public component function init() {
		variables.useJavaloader = false;

		if(variables.useJavaloader) {
			variables.javaloader = createObject('component','javaloader.JavaLoader').init([ expandPath('lib/mongo.jar'), expandPath('lib/jakarta-oro.jar') ]);
		}

		return this;
	}

	public any function getJavaObject( required string definition ) {
		if(variables.useJavaloader) {
			return variables.javaloader.create( arguments.definition );
		}

		return createObject('java', arguments.definition, 'lib/mongo.jar,lib/jakarta-oro.jar');
	}

	public boolean function isUsingJavaloader() {
		return variables.useJavaloader;
	}
}
