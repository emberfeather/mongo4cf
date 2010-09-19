component extends="test.base" {
	public void function setup() {}
	
	public void function testSucceedSansCollection() {
		var collection = variables.db.getCollection('database_collectionExists');
		
		// Remove the collection
		collection.drop();
		
		// Check if the collection exists
		assertFalse(variables.db.collectionExists('database_collectionExists'));
	}
	
	public void function testSucceedWithCollection() {
		var collection = variables.db.getCollection('database_collectionExists');
		
		// Remove the collection
		collection.insert({ 'test': 'truth' });
		
		// Check if the collection exists
		assertTrue(variables.db.collectionExists('database_collectionExists'));
	}
}
