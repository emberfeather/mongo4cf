component extends="mxunit.framework.TestCase" {
	/**
	 * Setup a database information
	 */
	public void function beforeTests() {
		variables.mongo = createObject('component', 'mongo4cf.mongo').init();
		variables.db = variables.mongo.getDB('mongo4cf_test');
	}
	
	/**
	 * Reset the collection for each test
	 */
	public void function setup( required string collectionName ) {
		// Make sure that the collection is fully empty before running tests
		variables.db.getCollection(arguments.collectionName).drop();
		
		// Create a new collection
		variables.collection = db.getCollection(arguments.collectionName);
	}
}
