component extends="test.base" {
	public void function setup() {
		super.setup('collection_getFullName');
	}
	
	public void function testSucceedWithName() {
		assertEquals('mongo4cf_test.collection_getFullName', variables.collection.getFullName());
	}
}
