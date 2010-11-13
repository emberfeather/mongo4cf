component extends="test.base" {
	public void function setup() {
		super.setup('collection_remove');
	}
	
	public void function testSucceedWithId() {
		variables.collection.insert({ '_id' = 1, 'test' = 'table' });
		variables.collection.insert({ '_id' = 2, 'test' = 'tables' });
		variables.collection.insert({ '_id' = 3, 'test' = 'tables' });
		
		assertEquals(3, variables.collection.find().count());
		
		variables.collection.remove({ '_id' = 2 });
		
		assertEquals(2, variables.collection.find().count());
	}
	
	public void function testSucceedWithQuery() {
		variables.collection.insert({ '_id' = 1, 'test' = 'table', 'x' = 11 });
		variables.collection.insert({ '_id' = 2, 'test' = 'tables', 'x' = 14 });
		variables.collection.insert({ '_id' = 3, 'test' = 'tables', 'x' = 5 });
		
		assertEquals(3, variables.collection.find().count());
		
		variables.collection.remove({ 'x' = { '$gt' = 10 } });
		
		assertEquals(1, variables.collection.find().count());
	}
}
