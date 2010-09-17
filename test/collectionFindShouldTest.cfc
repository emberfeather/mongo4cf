component extends="test.base" {
	public void function setup() {
		super.setup('collection_find');
	}
	
	public void function testSucceedWithOneDocument() {
		var result = '';
		
		variables.collection.insert({ 'test': 'working' });
		
		result = variables.collection.find();
		
		assertEquals(1, arrayLen(result));
	}
	
	public void function testSucceedWithTenDocuments() {
		var i = '';
		var results = '';
		
		for(i = 0; i < 10; i++) {
			variables.collection.insert({ 'test': 'working' });
		}
		
		results = variables.collection.find();
		
		assertEquals(10, arrayLen(results));
	}
	
	public void function testSucceedWithoutAnyDocuments() {
		var results = '';
		
		results = variables.collection.find();
		
		assertEquals(0, arrayLen(results));
	}
	
	public void function testSucceedWithColumnSubset() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working', 'testing': 'is it?' });
		
		results = variables.collection.find({}, { 'test': 1 });
		
		// Always going to return the _id
		assertEquals(2, structCount(results[1]));
	}
	
	public void function testSucceedWithColumnExclusion() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working', 'testing': 'is it?', 'other': true });
		
		results = variables.collection.find({}, { 'test': 0 });
		
		// Always going to return the _id
		assertEquals(3, structCount(results[1]));
	}
	
	public void function testSucceedWithDocumentSimple() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working' });
		variables.collection.insert({ 'test': 'not working' });
		
		results = variables.collection.find({ 'test': 'working' });
		
		assertEquals(1, arrayLen(results));
	}
	
	public void function testSucceedWithDocumentGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test': i });
		}
		
		results = variables.collection.find({ 'test': { '$gt': 5 } });
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithDocumentLessThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test': i });
		}
		
		results = variables.collection.find({ 'test': { '$lt': 5 } });
		
		assertEquals(4, arrayLen(results));
	}
}
