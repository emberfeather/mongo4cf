component {
	public component function init( string host = 'localhost', numeric port = 27017 ) {
		variables.host = arguments.host;
		variables.port = arguments.port;
		variables.databases = {};
		
		variables.mongo = createObject('java', 'com.mongodb.Mongo', '/mongo4cf/lib/mongo.jar').init(variables.host, variables.port);
		
		return this;
	}
	
	public void function close() {
		variables.mongo.close();
	}
	
	public void function dropDatabase( required string databaseName ) {
		variables.mongo.dropDatabase( arguments.databaseName );
	}
	
	public string function getAddress() {
		return variables.mongo.getAddress().toString();
	}
	
	public array function getAllAddress() {
		return variables.mongo.getAllAddress().toArray();
	}
	
	public string function getConnectPoint() {
		return variables.mongo.getConnectPoint();
	}
	
	public array function getDatabaseNames() {
		return variables.mongo.getDatabaseNames().toArray();
	}
	
	public component function getDB( required string databaseName ) {
		// Check for a cached version of the database
		if(structKeyExists(variables.databases, arguments.databaseName)) {
			return variables.databases[arguments.databaseName];
		}
		
		// Create a database object
		variables.databases[arguments.databaseName] = createObject('component', 'mongo4cf.database');
		
		// Populate the database with the results from the server
		variables.databases[arguments.databaseName].init(this, variables.mongo.getDB(arguments.databaseName));
		
		return variables.databases[arguments.databaseName];
	}
	
	public string function getHost() {
		return variables.host;
	}
	
	public numeric function getPort() {
		return variables.port;
	}
	
	public string function getVersion() {
		return variables.mongo.getVersion();
	}
	
	public string function _toString() {
		return variables.mongo.toString();
	}
	
	public any function _getRaw() {
		return variables.mongo;
	}
}
