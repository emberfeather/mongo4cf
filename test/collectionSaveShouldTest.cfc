component extends="test.base" {
	public void function setup() {
		super.setup('collection_save');
	}
	
	public void function testSucceedWithExisting() {
		var doc = { '_id' = 1, 'test' = 'is it?' };
		
		variables.collection.insert(doc);
		
		assertEquals( 1, variables.collection.getCount() );
		
		doc['test'] = 'working';
		
		variables.collection.save(doc);
		
		assertEquals( 1, variables.collection.getCount() );
		assertEquals( 'working', variables.collection.findOne().test );
	}
	
	public void function testSucceedWithoutExisting() {
		var doc = { '_id' = 1, 'test' = 'is it?' };
		
		variables.collection.save(doc);
		
		assertEquals( 1, variables.collection.getCount() );
		assertEquals( 'is it?', variables.collection.findOne().test );
	}
}
