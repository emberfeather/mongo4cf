component extends="test.base" {
	public void function setup() {
		super.setup('collection__addSpecial');
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithMaxScan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 25; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$gt' = 5 } })._addSpecial('$maxScan', 5).toArray();
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithReturnKey() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i, 'something', 'else' });
		}
		
		results = variables.collection.find()._addSpecial('$returnKey', true).toArray();
		
		assertEquals(1, structCount(results[1]));
	}
	*/
}
