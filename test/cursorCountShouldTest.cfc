component extends="test.base" {
	public void function setup() {
		super.setup('cursor_count');
	}
	
	public void function testSucceedSansDocuments() {
		assertEquals(0, variables.collection.find().count());
	}
	
	public void function testSucceedWithOneDocument() {
		variables.collection.insert({ 'test' = 'value' });
		
		assertEquals(1, variables.collection.find().count());
	}
	
	public void function testSucceedWithMultipleDocuments() {
		variables.collection.insert({ 'test' = 'value' });
		variables.collection.insert({ 'test' = 'value' });
		variables.collection.insert({ 'test' = 'value' });
		variables.collection.insert({ 'test' = 'value' });
		
		assertEquals(4, variables.collection.find().count());
	}
}
