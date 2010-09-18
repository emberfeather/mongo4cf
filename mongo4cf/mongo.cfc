component {
	public component function init( string host = 'localhost', numeric port = 27017 ) {
		variables.host = arguments.host;
		variables.port = arguments.port;
		variables.databases = {};
		
		variables.server = createObject('java', 'com.mongodb.Mongo', '/mongo4cf/lib/mongo.jar').init(variables.host, variables.port);
		
		return this;
	}
	
	public void function close() {
		variables.server.close();
	}
	
	public void function dropDatabase( required string databaseName ) {
		variables.server.dropDatabase( arguments.databaseName );
	}
	
	public string function getAddress() {
		return return variables.server.getAddress().toString();
	}
	
	public array function getAllAddress() {
		return return variables.server.getAllAddress().toArray();
	}
	
	public string function getConnectPoint() {
		return return variables.server.getConnectPoint();
	}
	
	public array function getDatabaseNames() {
		return variables.server.getDatabaseNames().toArray();
	}
	
	public component function getDB( required string databaseName ) {
		// Check for a cached version of the database
		if(structKeyExists(variables.databases, arguments.databaseName)) {
			return variables.databases[arguments.databaseName];
		}
		
		// Create a database object
		variables.databases[arguments.databaseName] = createObject('component', 'mongo4cf.database');
		
		// Populate the database with the results from the server
		variables.databases[arguments.databaseName].init(variables.server.getDB(arguments.databaseName));
		
		return variables.databases[arguments.databaseName];
	}
	
	public string function getHost() {
		return variables.host;
	}
	
	public numeric function getPort() {
		return variables.port;
	}
	
	public string function getVersion() {
		return return variables.server.getVersion();
	}
	
	public any function _getRaw() {
		return variables.server;
	}
}
