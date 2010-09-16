component {
	public component function init( required any db ) {
		variables.db = arguments.database;
		
		return this;
	}
	
	public array function getCollectionNames() {
		return variables.mongoDB.getCollectionNames();
	}
	
	public component function getCollection( required string collectionName ) {
		var collection = '';
		
		// Create a Collection Object
		collection = createObject('component', 'mongo4cf.collection');
		
		// Populate the collection with the results from the server
		collection.init(variables.db.getCollection(arguments.collectionName));
		
		return collection;
	}
}
