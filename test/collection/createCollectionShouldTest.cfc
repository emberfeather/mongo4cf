component extends="test.base" {
	public void function setup() {
		variables.collectionName = 'collection_createCollection';
	}
	
	public void function testSucceedWithCapped() {
		variables.collection = variables.db.getCollection(variables.collectionName);
		
		variables.collection.drop();
		
		variables.collection = variables.db.createCollection(variables.collectionName, { 'capped' = true });
		
		assertTrue(variables.collection.isCapped());
	}
}
