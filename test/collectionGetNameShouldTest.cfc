component extends="test.base" {
	public void function setup() {
		super.setup('collection_getName');
	}
	
	public void function testSucceedWithName() {
		assertEquals('collection_getName', variables.collection.getName());
	}
}
