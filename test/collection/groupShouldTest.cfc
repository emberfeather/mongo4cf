component extends="test.base" {
	public void function setup() {
		super.setup('collection_group');
	}
	
	public void function testSucceedWithoutDocs() {
		var result = '';
		
		result = variables.collection.group({}, {}, { 'count' = 0 }, 'function (obj, prev) { prev.count++; }').toArray();
		
		assertEquals(0, arrayLen(result));
	}
	
	public void function testSucceedWithNoQuery() {
		var result = '';
		
		variables.collection.insert({ 'a' = 2 });
		variables.collection.insert({ 'b' = 5 });
		variables.collection.insert({ 'a' = 1 });
		
		result = variables.collection.group({}, {}, { 'count' = 0 }, 'function (obj, prev) { prev.count++; }').toArray();
		
		assertEquals(1, arrayLen(result));
		assertEquals(3, result[1].count);
	}
	
	public void function testSucceedWithQuery() {
		var result = '';
		
		variables.collection.insert({ 'a' = 2 });
		variables.collection.insert({ 'b' = 5 });
		variables.collection.insert({ 'a' = 1 });
		
		result = variables.collection.group({}, { 'a' = { '$gt' = 1 } }, { 'count' = 0 }, 'function (obj, prev) { prev.count++; }').toArray();
		
		assertEquals(1, arrayLen(result));
		assertEquals(1, result[1].count);
	}
	
	public void function testSucceedWithKeysAndQuery() {
		var result = '';
		
		variables.collection.insert({ 'a' = 2 });
		variables.collection.insert({ 'b' = 5 });
		variables.collection.insert({ 'a' = 1 });
		variables.collection.insert({ 'a' = 2, 'b' = 3 });
		
		result = variables.collection.group({ 'a' = 1 }, {}, { 'count' = 0 }, 'function (obj, prev) { prev.count++; }').toArray();
		
		assertEquals(3, arrayLen(result));
		assertEquals(2, result[1].count);
		assertEquals(2, result[1].a);
		assertEquals(1, result[2].count);
		assertFalse(structKeyExists(result[2], 'a'));
		assertEquals(1, result[3].count);
		assertEquals(1, result[3].a);
	}
}
