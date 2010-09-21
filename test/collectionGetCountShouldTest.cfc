component extends="test.base" {
	public void function setup() {
		super.setup('collection_getCount');
	}
	
	public void function testSucceedWithoutDocuments() {
		assertEquals(0, variables.collection.getCount());
	}
	
	public void function testSucceedWithSingleDocument() {
		// Insert a single document
		variables.collection.insert({'testing': 'count'});
		
		assertEquals(1, variables.collection.getCount());
	}
	
	public void function testSucceedWithMultipleDocuments() {
		// Insert multiple documents
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		
		assertEquals(5, variables.collection.getCount());
	}
}
