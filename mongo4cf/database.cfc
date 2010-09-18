component {
	public component function init( required component mongo, required any db ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.mongo = arguments.mongo;
		variables.db = arguments.db;
		variables.collections = {};
		
		return this;
	}
	
	public void function addUser(required string username, required string password) {
		variables.db.addUser(arguments.username, arguments.password);
	}
	
	public boolean function authenticate(required string username, required string password) {
		return variables.db.authenticate(arguments.username, arguments.password);
	}
	
	public boolean function collectionExists(required string collectionName) {
		return variables.db.collectionExists(arguments.collectionName);
	}
	
	public boolean function createCollection(required string collectionName, required struct options) {
		var collection = variables.db.createCollection(arguments.collectionName, variables.utility.createBasicDBObject( duplicate( arguments.options ) ));
		
		return createObject('component', 'mongo4cf.collection').init(variables.mongo, this, collection);
	}
	
	public void function dropDatabase() {
		variables.db.dropDatabase();
	}
	
	public component function getCollection( required string collectionName ) {
		// Check for a cached version of the collection
		if(structKeyExists(variables.collections, arguments.collectionName)) {
			return variables.collections[arguments.collectionName];
		}
		
		// Create a collection object
		variables.collections[arguments.collectionName] = createObject('component', 'mongo4cf.collection');
		
		// Populate the collection with the results from the server
		variables.collections[arguments.collectionName].init(variables.mongo, this, variables.db.getCollection(arguments.collectionName));
		
		return variables.collections[arguments.collectionName];
	}
	
	public array function getCollectionNames() {
		return variables.db.getCollectionNames().toArray();
	}
	
	public component function getMongo() {
		return variables.mongo;
	}
	
	public string function getName() {
		return variables.db.getName();
	}
	
	public string function getSisterDB() {
		var database = variables.db.getSisterDB();
		
		return createObject('component', 'mongo4cf.database').init(variables.mongo, database);
	}
	
	public boolean function isAuthenticated() {
		return variables.db.isAuthenticated();
	}
	
	public void function resetIndexCache() {
		variables.db.resetIndexCache();
	}
	
	public void function setReadOnly( required boolean isReadOnly ) {
		variables.db.setReadOnly( arguments.isReadOnly );
	}
	
	public string function _toString() {
		return variables.db.toString();
	}
	
	public any function _getRaw() {
		return variables.db;
	}
}
