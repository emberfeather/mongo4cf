component extends="test.base" {
	public void function setup() {
		super.setup('collection_find');
	}
	
	public void function testSucceedWithOneDocument() {
		var result = '';
		
		variables.collection.insert({ 'test' = 'working' });
		
		result = variables.collection.find().toArray();
		
		assertEquals(1, arrayLen(result));
	}
	
	public void function testSucceedWithTenDocuments() {
		var i = '';
		var results = '';
		
		for(i = 0; i < 10; i++) {
			variables.collection.insert({ 'test' = 'working' });
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
		
		variables.collection.insert({ 'test' = 'working', 'testing' = 'is it?' });
		
		results = variables.collection.find({}, { 'test' = 1 }).toArray();
		
		// Always going to return the _id
		assertEquals(2, structCount(results[1]));
	}
	
	public void function testSucceedWithColumnExclusion() {
		var results = '';
		
		variables.collection.insert({ 'test' = 'working', 'testing' = 'is it?', 'other' = true });
		
		results = variables.collection.find({}, { 'test' = 0 }).toArray();
		
		// Always going to return the _id
		assertEquals(3, structCount(results[1]));
	}
	
	public void function testSucceedWithQueryID() {
		var results = '';
		
		variables.collection.insert({ '_id' = '8CDFB14B0B952854', 'test' = 12345 });
		
		results = variables.collection.find({ '_id' = '8CDFB14B0B952854' }).toArray();
		
		assertEquals(1, arrayLen(results));
		assertEquals(12345, results[1].test);
	}
	
	public void function testSucceedWithQueryOperatorAll() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = [i, i+1, i+2, i+3, i+4] });
		}
		
		results = variables.collection.find({ 'test' = { '$all' = [ 3, 4 ] } }).toArray();
		
		assertEquals(3, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorElemMatch() {
		var results = '';
		
		variables.collection.insert({
			'foo' = [
				{
					'shape' = 'square',
					'color' = 'purple',
					'thick' = false
				},
				{
					'shape' = 'circle',
					'color' = 'red',
					'thick' = true
				}
			]
		});
		
		variables.collection.insert({
			'foo' = [
				{
					'shape' = 'square',
					'color' = 'red',
					'thick' = true
				},
				{
					'shape' = 'circle',
					'color' = 'purple',
					'thick' = false
				}
			]
		});
		
		results = variables.collection.find({ 'foo' = {'$elemMatch' = { 'shape' = 'square', 'color' = 'purple'} } }).toArray();
		
		assertEquals(1, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorExistsFalse() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'something' });
		variables.collection.insert({ 'ordeal' = 'something' });
		variables.collection.insert({ 'mass' = 'solid' });
		variables.collection.insert({ 'pressure' = 'something' });
		variables.collection.insert({ 'taste' = 'something', 'ordeal' = 'quite' });
		
		results = variables.collection.find({ 'ordeal' = { '$exists' = false } }).toArray();
		
		assertEquals(3, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorExistsTrue() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'something' });
		variables.collection.insert({ 'ordeal' = 'something' });
		variables.collection.insert({ 'mass' = 'solid' });
		variables.collection.insert({ 'pressure' = 'something' });
		variables.collection.insert({ 'taste' = 'something', 'ordeal' = 'quite' });
		
		results = variables.collection.find({ 'ordeal' = { '$exists' = true } }).toArray();
		
		assertEquals(2, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$gt' = 5 } }).toArray();
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorGreaterThanEqualTo() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$gte' = 5 } }).toArray();
		
		assertEquals(6, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorIn() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$in' = [ 3, 5, 7 ] } }).toArray();
		
		assertEquals(3, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorLessThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$lt' = 5 } }).toArray();
		
		assertEquals(4, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorLessThanEqualTo() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$lte' = 5 } }).toArray();
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorMod() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$mod' = [ 2, 1 ] } }).toArray();
		
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorNotEquals() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$ne' = 5 } }).toArray();
		
		assertEquals(9, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorNot() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$not' = { '$gt' = 4 } } }).toArray();
		
		assertEquals(4, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorNotIn() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$nin' = [ 3, 5, 7 ] } }).toArray();
		
		assertEquals(7, arrayLen(results));
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorOr() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ 'test' = { '$or' = [ { 'test' = 2 }, { 'test' = 5 } ] } }).toArray();
		
		assertEquals(2, arrayLen(results));
	}
	*/
	
	public void function testSucceedWithQueryOperatorRegularExpressionFlagCaseInsensitive() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.find({ 'test' = variables.collection.regex('monk', 'i') }).toArray();
		assertEquals(3, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionFlagExtended() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.find({ 'test' = variables.collection.regex('n	k', 'x') }).toArray();
		assertEquals(3, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionFlagMultiline() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my' & chr(10) & '2cents' });
		variables.collection.insert({ 'test' = 'bulls' & chr(10) & '2bear' });
		variables.collection.insert({ 'test' = 'my' & chr(10) & '2monkies' });
		variables.collection.insert({ 'test' = 'my' & chr(10) & '4mOnkies' });
		variables.collection.insert({ 'test' = 'your' & chr(10) & '4monks' });
		
		results = variables.collection.find({ 'test' = variables.collection.regex('s$', 'm') }).toArray();
		assertEquals(5, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionString() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.find({ 'test' = variables.collection.regex('monk') }).toArray();
		assertEquals(2, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionWildcard() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.find({ 'test' = variables.collection.regex('2.*s') }).toArray();
		assertEquals(2, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorSize() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = [ 1 ] });
		variables.collection.insert({ 'test' = [ 1, 2 ] });
		variables.collection.insert({ 'test' = [ 1, 2 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3, 4 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3, 4 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3, 4 ] });
		variables.collection.insert({ 'test' = [ 1, 2, 3, 4 ] });
		
		results = variables.collection.find({ 'test' = { '$size' = 3 } }).toArray();
		
		assertEquals(3, arrayLen(results));
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorSliceWithNegative() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x' = { '$slice' = -3 } }).toArray();
		
		assertEquals([1, 2, 3], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithPositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x' = { '$slice' = 3 } }).toArray();
		
		assertEquals([-3, -2, -1], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithRangePositivePositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x' = { '$slice' = [2, 3] } }).toArray();
		
		assertEquals([2, 3, 4], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithRangeNegativePositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.find({ 'x' = { '$slice' = [-5, 4] } }).toArray();
		assertEquals([-5, -4, -3, -2], results[1].x);
		
		results = variables.collection.find({ 'x' = { '$slice' = [-5, 20] } }).toArray();
		assertEquals([-5, -4, -3, -2, -1], results[1].x);
	}
	*/
	
	public void function testSucceedWithQueryOperatorValueInArray() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = ['red', 'green', 'purple'] });
		variables.collection.insert({ 'test' = ['red', 'blue', 'green', 'purple'] });
		variables.collection.insert({ 'test' = ['green', 'purple'] });
		variables.collection.insert({ 'test' = ['red', 'blue'] });
		
		results = variables.collection.find({ 'test' = 'blue' }).toArray();
		
		assertEquals(2, arrayLen(results));
	}
	
	public void function testSucceedWithQueryOperatorValueInEmbeddedObject() {
		var results = '';
		
		variables.collection.insert({
			'foo' = [
				{
					'shape' = 'triangle',
					'color' = 'purple'
				}
			]
		});
		
		variables.collection.insert({
			'foo' = [
				{
					'shape' = 'square',
					'color' = 'red'
				},
				{
					'shape' = 'octagon',
					'color' = 'green'
				}
			]
		});
		
		variables.collection.insert({
			'foo' = [
				{
					'shape' = 'circle',
					'color' = 'green'
				}
			]
		});
		
		results = variables.collection.find({ 'foo.color' = 'green'}).toArray();
		
		assertEquals(2, arrayLen(results));
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorWhereGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.find({ '$where' = 'test > 3' }).toArray();
		
		assertEquals(6, arrayLen(results));
	}
	*/
	
	public void function testSucceedWithQuerySimple() {
		var results = '';
		
		variables.collection.insert({ 'test' = 'working' });
		variables.collection.insert({ 'test' = 'not working' });
		
		results = variables.collection.find({ 'test' = 'working' }).toArray();
		
		assertEquals(1, arrayLen(results));
	}
}
