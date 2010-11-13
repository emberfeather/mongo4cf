component extends="test.base" {
	public void function setup() {
		super.setup('collection_findAndModify');
	}
	
	public void function testReturnAfterUpdateNewDocument() {
		var result = '';
		var i = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i, 'inProgress' = false, 'value' = 0 });
		}
		
		result = variables.collection.findAndModify( {}, {}, {}, false, { '$set' = { 'inProgress' = true }, '$inc' = { 'value' = 1 } }, true, false );
		
		assertEquals(1, result.value);
		assertEquals(true, result.inProgress);
	}
	
	public void function testReturnAfterUpdateOldDocument() {
		var result = '';
		var i = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i, 'inProgress' = false, 'value' = 0 });
		}
		
		result = variables.collection.findAndModify( {}, { '$set' = { 'inProgress' = true }, '$inc' = { 'value' = 1 } } );
		
		assertEquals(0, result.value);
		assertEquals(false, result.inProgress);
	}
	
	public void function testReturnMatchingQuery() {
		var result = '';
		var i = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i, 'inProgress' = false, 'value' = 0 });
		}
		
		result = variables.collection.findAndModify( { 'inProgress' = false }, {}, { 'priority' = -1 }, false, { '$set' = { 'inProgress' = true } }, false, false );
		
		assertEquals(9, result.priority);
		
		result = variables.collection.findAndModify( { 'inProgress' = false }, {}, { 'priority' = -1 }, false, { '$set' = { 'inProgress' = true } }, false, false );
		
		assertEquals(8, result.priority);
	}
	
	public void function testReturnAndRemove() {
		var i = '';
		var result = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i, 'inProgress' = false, 'value' = 0 });
		}
		
		result = variables.collection.findAndModify( {}, {}, { 'priority' = 1 }, true, {}, false, false );
		
		assertEquals(0, result.priority);
		
		result = variables.collection.findAndModify( {}, {}, { 'priority' = 1 }, true, {}, false, false );
		
		assertEquals(1, result.priority);
	}
	
	public void function testNoResultWithoutMatchingQuery() {
		var i = '';
		var result = '';
		
		for( i = 0; i < 10; i++ ) {
			variables.collection.insert({ 'priority' = i, 'inProgress' = false, 'value' = 0 });
		}
		
		result = variables.collection.findAndModify( { 'noSuchField' = true }, {}, {}, true, {}, false, false );
		
		assertTrue( structIsEmpty(result) );
	}
}
