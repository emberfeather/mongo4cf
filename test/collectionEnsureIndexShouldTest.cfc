component extends="test.base" {
	public void function setup() {
		super.setup('collection_ensureIndex');
	}
	
	public void function testSucceedWithOneCall() {
		variables.collection.insert({ 'x' = 12345 });
		
		// Size before adding index
		assertEquals( 1, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.ensureIndex({ 'x' = 1 });
		
		assertEquals( 2, arrayLen(variables.collection.getIndexInfo()) );
	}
	
	public void function testSucceedWithMultipleCalls() {
		variables.collection.insert({ 'x' = 12345 });
		
		// Size before adding index
		assertEquals( 1, arrayLen(variables.collection.getIndexInfo()) );
		
		variables.collection.ensureIndex({ 'x' = 1 });
		variables.collection.ensureIndex({ 'x' = 1 });
		variables.collection.ensureIndex({ 'x' = 1 });
		
		assertEquals( 2, arrayLen(variables.collection.getIndexInfo()) );
	}
}
