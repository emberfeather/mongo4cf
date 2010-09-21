component extends="test.base" {
	public void function setup() {
		super.setup('collection_drop');
	}
	
	public void function testSucceedWithRecords() {
		// Insert multiple documents
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		
		// Drop all inserted
		variables.collection.drop();
		
		// Insert multiple documents
		variables.collection.insert({'testing': 'count'});
		variables.collection.insert({'testing': 'count'});
		
		assertEquals(2, variables.collection.getCount());
	}
}
