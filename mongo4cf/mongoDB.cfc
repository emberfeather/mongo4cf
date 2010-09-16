component {
	public component function init( string host = 'localhost', numeric port = 27017 ) {
		variables.host = arguments.host;
		variables.port = arguments.port;
		
		variables.mongoDB = createObject('java', 'com.mongodb.Mongo', '/mongo4cf/lib/mongo.jar').init(variables.host, variables.port);
		
		return this;
	}
	
	public component function getDB( required string databaseName ) {
		var db = '';
		
		// Create a Collection Object
		db = createObject('component', 'mongo4cf.collection');
		
		// Populate the collection with the results from the server
		db.init(variables.mongoDB.getDB(arguments.databaseName));
		
		return db;
	}
	
	public string function getHost() {
		return variables.host;
	}
	
	public numeric function getPort() {
		return variables.port;
	}
}
