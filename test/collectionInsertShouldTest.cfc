component extends="test.base" {
	public void function setup() {
		super.setup('collection_insert');
	}
	
	public void function testSucceedWithBasicDocument() {
		var result = '';
		
		variables.collection.insert({ 'test': 'working' });
		
		result = variables.collection.findOne();
		
		assertEquals('working', result.test);
	}
}
