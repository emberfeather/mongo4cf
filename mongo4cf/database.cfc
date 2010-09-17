component {
	public component function init( required any db ) {
		variables.db = arguments.db;
		variables.collections = {};
		
		return this;
	}
	
	public boolean function authenticate(required string username, required string password) {
		return variables.db.authenticate(arguments.username, arguments.password);
	}
	
	public array function getCollectionNames() {
		return variables.db.getCollectionNames().toArray();
	}
	
	public component function getCollection( required string collectionName ) {
		// Check for a cached version of the collection
		if(structKeyExists(variables.collections, arguments.collectionName)) {
			return variables.collections[arguments.collectionName];
		}
		
		// Create a collection object
		variables.collections[arguments.collectionName] = createObject('component', 'mongo4cf.collection');
		
		// Populate the collection with the results from the server
		variables.collections[arguments.collectionName].init(variables.db.getCollection(arguments.collectionName));
		
		return variables.collections[arguments.collectionName];
	}
	
	public any function _getRaw() {
		return variables.db;
	}
}
