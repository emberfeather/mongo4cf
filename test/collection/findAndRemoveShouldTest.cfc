component extends="test.base" {
	public void function setup() {
		super.setup('collection_findAndModify');
	}
	
	public void function testReturnAfterRemovalWithQuery() {
		var result = '';
		var i = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i });
		}
		
		result = variables.collection.findAndRemove( { 'priority' = { '$gt' = 5 } } );
		
		assertEquals(6, result.priority);
		
		assertEquals(9, variables.collection.getCount());
	}
	
	public void function testReturnAfterRemovalWithoutQuery() {
		var result = '';
		var i = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i });
		}
		
		result = variables.collection.findAndRemove( {} );
		
		assertEquals(0, result.priority);
		
		result = variables.collection.findAndRemove( {} );
		
		assertEquals(1, result.priority);
		
		assertEquals(8, variables.collection.getCount());
	}
}
