component {
	public component function init( required component mongo, required any db ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.mongo = arguments.mongo;
		variables.db = arguments.db;
		variables.collections = {};
		
		return this;
	}
	
	public void function addUser(required string username, required string password, boolean readOnly = false) {
		variables.db.addUser(arguments.username, arguments.password.toCharArray(), arguments.readOnly);
	}
	
	public boolean function authenticate(required string username, required string password) {
		return variables.db.authenticate(arguments.username, arguments.password.toCharArray());
	}
	
	public boolean function collectionExists(required string collectionName) {
		return variables.db.collectionExists(arguments.collectionName);
	}
	
	public component function createCollection(required string collectionName, required struct options) {
		var collection = variables.db.createCollection(arguments.collectionName, variables.utility.createBasicDBObject( arguments.options ));
		
		variables.collections[arguments.collectionName] = createObject('component', 'mongo4cf.collection').init(this, collection);
		
		return variables.collections[arguments.collectionName];
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
		variables.collections[arguments.collectionName].init(this, variables.db.getCollection(arguments.collectionName));
		
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
	
	public void function removeUser(required string username) {
		variables.db.removeUser(arguments.username);
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
