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
	
	public void function testSucceedWithMultipleDocumentsAsArguments() {
		var result = '';
		
		variables.collection.insert(
			{ 'test': 'working1' },
			{ 'test': 'working2' },
			{ 'test': 'working3' },
			{ 'test': 'working4' }
		);
		
		assertEquals(4, variables.collection.getCount());
	}
	
	public void function testSucceedWithMultipleDocumentsAsArray() {
		var result = '';
		
		variables.collection.insert([
			{ 'test': 'working1' },
			{ 'test': 'working2' },
			{ 'test': 'working3' },
			{ 'test': 'working4' }
		]);
		
		assertEquals(4, variables.collection.getCount());
	}
}
