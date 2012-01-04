component extends="test.base" {
	public void function setup() {
		super.setup('collection_findOne');
	}
	
	public void function testReturnEmptyWithoutResults() {
		assertTrue(structIsEmpty(variables.collection.findOne()));
	}
	
	public void function testReturnRecordWithIdWithResults() {
		variables.collection.insert({ '_id' = 123, 'test' = 'hello' });
		
		assertFalse(structIsEmpty(variables.collection.findOne( 123 )));
	}
	
	public void function testReturnRecordWithIdWithKeyFilterWithResults() {
		var result = '';
		
		variables.collection.insert({ '_id' = 123, 'i' = 2, 'y' = 3, 'z' = 4 });
		
		result = variables.collection.findOne( 123, { 'z' = 0 } );
		
		assertEquals(2, result.i);
		assertEquals(3, result.y);
		assertFalse(structKeyExists(result, 'z'));
	}
	
	public void function testReturnRecordWithIdWithoutResults() {
		variables.collection.insert({ '_id' = 123, 'test' = 'hello' });
		
		assertTrue(structIsEmpty(variables.collection.findOne( 321 )));
	}
	
	public void function testReturnRecordWithRecordsWithQueryWithResults() {
		variables.collection.insert({ 'test' = 'hello' });
		
		assertFalse(structIsEmpty(variables.collection.findOne( { 'test' = 'hello' } )));
	}
	
	public void function testReturnRecordWithRecordsWithQueryWithKeyFilterWithResults() {
		var result = '';
		
		variables.collection.insert({ 'test' = 'hello', 'other' = 'yes' });
		
		result = variables.collection.findOne( { 'test' = 'hello' }, { 'other' = 0 } );
		
		assertEquals('hello', result.test);
		assertFalse(structKeyExists(result, 'other'));
	}
	
	public void function testReturnEmptyWithRecordsWithQueryWithoutResults() {
		variables.collection.insert({ 'test' = 'hello' });
		
		assertTrue(structIsEmpty(variables.collection.findOne( { 'test' = 'world' } )));
	}
	
	public void function testReturnRecordWithoutIdWithGeneratedID() {
		variables.collection.insert({ 'test' = 'hello' });
		
		local.result = variables.collection.findOne();
		
		assertFalse(structIsEmpty(variables.collection.findOne({ '_id': local.result._id })));
	}
	
	public void function testReturnRecordWithoutIdWithGeneratedIDUsingUtility() {
		variables.collection.insert({ 'test' = 'hello' });
		
		local.result = variables.collection.findOne();
		
		assertFalse(structIsEmpty(variables.collection.findOne({ '_id': variables.utility.objectID(local.result._id) })));
	}
	
	public void function testReturnRecordWithoutIdWithResults() {
		variables.collection.insert({ 'test' = 'hello' });
		
		assertFalse(structIsEmpty(variables.collection.findOne()));
	}
}
