component extends="test.base" {
	public void function setup() {
		super.setup('collection_equals');
	}
	
	public void function testSucceedWithSame() {
		var collection = variables.db.getCollection('collection_equals');
		
		assertTrue(variables.collection.equals(collection));
	}
	
	public void function testSucceedWithDifferent() {
		var collection = variables.db.getCollection('collection_equals_not');
		
		assertFalse(variables.collection.equals(collection));
	}
}
