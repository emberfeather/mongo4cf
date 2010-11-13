component extends="test.base" {
	public void function setup() {
		super.setup('collection_createIndex');
	}
	
	public void function testSucceedWhenNoIndexes() {
		// Remove all previous indexes
		variables.collection.dropIndexes();
		
		// Create a new index
		variables.collection.createIndex({ 'i' = 1 });
		
		// There will always be an index for _id
		assertEquals(2, arrayLen(variables.collection.getIndexInfo()));
	}
}
