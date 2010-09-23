component extends="test.base" {
	public void function setup() {
		super.setup('collection_find');
	}
	
	public void function testSucceedWithOneDocument() {
		var result = '';
		
		variables.collection.insert({ 'test': 'working' });
		
		result = variables.collection.find().toArray();
		
		assertEquals(1, arrayLen(result));
	}
	
	public void function testSucceedWithTenDocuments() {
		var i = '';
		var results = '';
		
		for(i = 0; i < 10; i++) {
			variables.collection.insert({ 'test': 'working' });
		}
		
		results = variables.collection.find().toArray();
		
		assertEquals(10, arrayLen(results));
	}
	
	public void function testSucceedWithoutAnyDocuments() {
		var results = '';
		
		results = variables.collection.find().toArray();
		
		assertEquals(0, arrayLen(results));
	}
	
	public void function testSucceedWithColumnSubset() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working', 'testing': 'is it?' });
		
		results = variables.collection.find({}, { 'test': 1 }).toArray();
		
		// Always going to return the _id
		assertEquals(2, structCount(results[1]));
	}
	
	public void function testSucceedWithColumnExclusion() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working', 'testing': 'is it?', 'other': true });
		
		results = variables.collection.find({}, { 'test': 0 }).toArray();
		
		// Always going to return the _id
		assertEquals(3, structCount(results[1]));
	}
	
	public void function testSucceedWithQuerySimple() {
		var results = '';
		
		variables.collection.insert({ 'test': 'working' });
		variables.collection.insert({ 'test': 'not working' });
		
		results = variables.collection.find({ 'test': 'working' }).toArray();
		
		assertEquals(1, arrayLen(results));
	}
	
	public void function testSucceedWithQueryGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test': i });
		}
		
		results = variables.collection.find({ 'test': { '$gt': 5 } }).toArray();
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithQueryLessThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test': i });
		}
		
		results = variables.collection.find({ 'test': { '$lt': 5 } }).toArray();
		
		assertEquals(4, arrayLen(results));
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQuerySliceWithNegative() {
		var results = '';
		
		variables.collection.insert({
			'test': 'something',
			'x': [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x': { '$slice': -3 } }).toArray();
		
		assertEquals([1, 2, 3], results[1].x);
	}
	
	public void function testSucceedWithQuerySliceWithPositive() {
		var results = '';
		
		variables.collection.insert({
			'test': 'something',
			'x': [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x': { '$slice': 3 } }).toArray();
		
		assertEquals([-3, -2, -1], results[1].x);
	}
	
	public void function testSucceedWithQuerySliceWithRangePositivePositive() {
		var results = '';
		
		variables.collection.insert({
			'test': 'something',
			'x': [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x': { '$slice': [2, 3] } }).toArray();
		
		assertEquals([2, 3, 4], results[1].x);
	}
	
	public void function testSucceedWithQuerySliceWithRangeNegativePositive() {
		var results = '';
		
		variables.collection.insert({
			'test': 'something',
			'x': [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x': { '$slice': [-5, 4] } }).toArray();
		assertEquals([-5, -4, -3, -2], results[1].x);
		
		results = variables.collection.find({ 'x': { '$slice': [-5, 20] } }).toArray();
		assertEquals([-5, -4, -3, -2, -1], results[1].x);
	}
	*/
}
