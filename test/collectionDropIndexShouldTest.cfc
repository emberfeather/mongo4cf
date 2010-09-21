component extends="test.base" {
	public void function setup() {
		super.setup('collection_ensureIndex');
	}
	
	public void function testSucceedWithOneIndex() {
		variables.collection.insert({ 'x': 12345 });
		
		// Size before adding index
		assertEquals( 1, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.ensureIndex({ 'x': 1 });
		
		assertEquals( 2, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.dropIndex({ 'x': 1 });
		
		assertEquals( 1, arrayLen(variables.collection.getIndexInfo()) );
	}
	
	public void function testSucceedWithMultipleIndexes() {
		variables.collection.insert({ 'x': 12345, 'y': 54321 });
		
		// Size before adding index
		assertEquals( 1, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.ensureIndex({ 'x': 1 });
		variables.collection.ensureIndex({ 'x': -1 });
		variables.collection.ensureIndex({ 'y': -1 });
		
		assertEquals( 4, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.dropIndex({ 'x': 1 });
		variables.collection.dropIndex({ 'y': -1 });
		
		assertEquals( 2, arrayLen(variables.collection.getIndexInfo()) );
	}
}
