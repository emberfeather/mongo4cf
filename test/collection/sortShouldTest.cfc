component extends="test.base" {
	public void function setup() {
		// Make sure that the collection is fully empty before running tests
		db.getCollection('collection_sort').drop();
		
		// Capped collection so the natural ordering is guarenteed
		variables.collection = db.createCollection('collection_sort', { 'capped' = true, 'size' = 10000 });
	}
	
	public void function testSucceedWithAttribute() {
		var results = '';
		
		variables.collection.insert({ 'test' = 1 });
		variables.collection.insert({ 'test' = 148 });
		variables.collection.insert({ 'test' = 215 });
		variables.collection.insert({ 'test' = 11 });
		
		results = variables.collection.find().sort({ 'test' = 1 }).toArray();
		
		assertEquals( 1, results[1].test );
		assertEquals( 11, results[2].test );
		assertEquals( 148, results[3].test );
		assertEquals( 215, results[4].test );
	}
	
	public void function testSucceedWithAttributeReverse() {
		var results = '';
		
		variables.collection.insert({ 'test' = 1 });
		variables.collection.insert({ 'test' = 148 });
		variables.collection.insert({ 'test' = 215 });
		variables.collection.insert({ 'test' = 11 });
		
		results = variables.collection.find().sort({ 'test' = -1 }).toArray();
		
		assertEquals( 215, results[1].test );
		assertEquals( 148, results[2].test );
		assertEquals( 11, results[3].test );
		assertEquals( 1, results[4].test );
	}
	
	public void function testSucceedWithNatural() {
		var results = '';
		
		variables.collection.insert({ 'test' = 1 });
		variables.collection.insert({ 'test' = 148 });
		variables.collection.insert({ 'test' = 215 });
		variables.collection.insert({ 'test' = 11 });
		
		results = variables.collection.find().sort({ '$natural' = 1 }).toArray();
		
		assertEquals( 1, results[1].test );
		assertEquals( 148, results[2].test );
		assertEquals( 215, results[3].test );
		assertEquals( 11, results[4].test );
	}
	
	public void function testSucceedWithNaturalReverse() {
		var results = '';
		
		variables.collection.insert({ 'test' = 1 });
		variables.collection.insert({ 'test' = 148 });
		variables.collection.insert({ 'test' = 215 });
		variables.collection.insert({ 'test' = 11 });
		
		results = variables.collection.find().sort({ '$natural' = -1 }).toArray();
		
		assertEquals( 11, results[1].test );
		assertEquals( 215, results[2].test );
		assertEquals( 148, results[3].test );
		assertEquals( 1, results[4].test );
	}
}
