component extends="test.base" {
	public void function setup() {
		super.setup('collection_update');
	}
	
	public void function testSucceedWithID() {
		variables.collection.insert({ '_id' = 1, 'test' = 'is it?' });
		
		assertEquals( 'is it?', variables.collection.findOne().test );
		
		variables.collection.update({ '_id' = 1 }, { 'test' = 'working' });
		
		assertEquals( 'working', variables.collection.findOne().test );
	}
	
	public void function testSucceedWithMultiFalse() {
		variables.collection.insert({ '_id' = 1, 'test' = 'is it?' });
		variables.collection.insert({ '_id' = 2, 'test' = 'is it?' });
		
		assertEquals( 'is it?', variables.collection.find({ '_id' = 1 }).toArray()[1].test );
		assertEquals( 'is it?', variables.collection.find({ '_id' = 2 }).toArray()[1].test );
		
		variables.collection.update({ 'test' = 'is it?' }, { 'test' = 'working' });
		
		// The first found should be changed only
		assertEquals( 'working', variables.collection.find({ '_id' = 1 }).toArray()[1].test );
		assertEquals( 'is it?', variables.collection.find({ '_id' = 2 }).toArray()[1].test );
	}
	
	public void function testSucceedWithMultiTrue() {
		var doc = '';
		var results = '';
		
		variables.collection.insert({ 'x' = 4, 'y' = 3 });
		variables.collection.insert({ 'x' = 5, 'y' = 5 });
		variables.collection.insert({ 'x' = 4, 'y' = 4 });
		
		variables.collection.update( { 'x' = 4 }, { '$set' = { 'y' = 5 } }, false, true );
		
		assertEquals( 3, variables.collection.getCount() );
		
		results = variables.collection.find().toArray();
		
		for(doc in results) {
			assertEquals(5, doc.y);
		}
	}
	
	public void function testSucceedWithUpsert() {
		variables.collection.update({ 'page' = '/' }, { '$inc': { 'count': 1 } }, true, false);
		variables.collection.update({ 'page' = '/' }, { '$inc': { 'count': 1 } }, true, false);
		
		assertEquals( 1, variables.collection.getCount() );
		assertEquals( 2, variables.collection.findOne().count );
	}
}
