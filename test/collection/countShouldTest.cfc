component extends="test.base" {
	public void function setup() {
		super.setup('collection_count');
		
		variables.utility = createObject('component', 'mongo4cf.utility').init();
	}
	
	public void function testSucceedWithOneDocument() {
		var result = '';
		
		variables.collection.insert({ 'test' = 'working' });
		
		result = variables.collection.count();
		
		assertEquals(1, result);
	}
	
	public void function testSucceedWithTenDocuments() {
		var i = '';
		var results = '';
		
		for(i = 0; i < 10; i++) {
			variables.collection.insert({ 'test' = 'working' });
		}
		
		results = variables.collection.count();
		
		assertEquals(10, results);
	}
	
	public void function testSucceedWithoutAnyDocuments() {
		var results = '';
		
		results = variables.collection.count();
		
		assertEquals(0, results);
	}
	
	public void function testSucceedWithQueryID() {
		var results = '';
		
		variables.collection.insert({ '_id' = '8CDFB14B0B952854', 'test' = 12345 });
		
		results = variables.collection.count({ '_id' = '8CDFB14B0B952854' });
		
		assertEquals(1, results);
	}
	
	public void function testSucceedWithQueryOperatorAll() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = [i, i+1, i+2, i+3, i+4] });
		}
		
		results = variables.collection.count({ 'test' = { '$all' = [ 3, 4 ] } });
		
		assertEquals(3, results);
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
		
		results = variables.collection.count({ 'foo' = {'$elemMatch' = { 'shape' = 'square', 'color' = 'purple'} } });
		
		assertEquals(1, results);
	}
	
	public void function testSucceedWithQueryOperatorExistsFalse() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'something' });
		variables.collection.insert({ 'ordeal' = 'something' });
		variables.collection.insert({ 'mass' = 'solid' });
		variables.collection.insert({ 'pressure' = 'something' });
		variables.collection.insert({ 'taste' = 'something', 'ordeal' = 'quite' });
		
		results = variables.collection.count({ 'ordeal' = { '$exists' = false } });
		
		assertEquals(3, results);
	}
	
	public void function testSucceedWithQueryOperatorExistsTrue() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'something' });
		variables.collection.insert({ 'ordeal' = 'something' });
		variables.collection.insert({ 'mass' = 'solid' });
		variables.collection.insert({ 'pressure' = 'something' });
		variables.collection.insert({ 'taste' = 'something', 'ordeal' = 'quite' });
		
		results = variables.collection.count({ 'ordeal' = { '$exists' = true } });
		
		assertEquals(2, results);
	}
	
	public void function testSucceedWithQueryOperatorGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$gt' = 5 } });
		
		assertEquals(5, results);
	}
	
	public void function testSucceedWithQueryOperatorGreaterThanWithDate() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$gt' = dateAdd('d', 4, startDate) } });
		
		assertEquals(6, results);
	}
	
	public void function testSucceedWithQueryOperatorGreaterThanEqualTo() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$gte' = 5 } });
		
		assertEquals(6, results);
	}
	
	public void function testSucceedWithQueryOperatorGreaterThanEqualToWithDate() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$gte' = dateAdd('d', 8, startDate) } });
		
		assertEquals(3, results);
	}
	
	public void function testSucceedWithQueryOperatorIn() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$in' = [ 3, 5, 7 ] } });
		
		assertEquals(3, results);
	}
	
	public void function testSucceedWithQueryOperatorLessThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$lt' = 5 } });
		
		assertEquals(4, results);
	}
	
	public void function testSucceedWithQueryOperatorLessThanWithDate() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$lt' = dateAdd('d', 5, startDate) } });
		
		assertEquals(4, results);
	}
	
	public void function testSucceedWithQueryOperatorLessThanEqualTo() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$lte' = 5 } });
		
		assertEquals(5, results);
	}
	
	public void function testSucceedWithQueryOperatorLessThanEqualToWithDate() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$lte' = dateAdd('d', 8, startDate) } });
		
		assertEquals(8, results);
	}
	
	public void function testSucceedWithQueryOperatorMod() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$mod' = [ 2, 1 ] } });
		
		assertEquals(5, results);
	}
	
	public void function testSucceedWithQueryOperatorNotEquals() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$ne' = 5 } });
		
		assertEquals(9, results);
	}
	
	public void function testSucceedWithQueryOperatorNotEqualsWithDate() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$ne' = dateAdd('d', 4, startDate) } });
		
		assertEquals(9, results);
	}
	
	public void function testSucceedWithQueryOperatorNotEqualsWithDateRaw() {
		var i = '';
		var results = '';
		var startDate = createDate(2010, 10, 10);
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'value' = dateAdd('d', i, startDate) });
		}
		
		results = variables.collection.count({ 'value' = { '$ne' = '2010/10/14' } });
		
		assertEquals(9, results);
	}
	
	public void function testSucceedWithQueryOperatorNot() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$not' = { '$gt' = 4 } } });
		
		assertEquals(4, results);
	}
	
	public void function testSucceedWithQueryOperatorNotIn() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$nin' = [ 3, 5, 7 ] } });
		
		assertEquals(7, results);
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorOr() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ 'test' = { '$or' = [ { 'test' = 2 }, { 'test' = 5 } ] } });
		
		assertEquals(2, results);
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
		
		results = variables.collection.count({ 'test' = variables.utility.regex('monk', 'i') });
		
		assertEquals(3, results);
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionFlagExtended() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.count({ 'test' = variables.utility.regex('n	k', 'x') });
		assertEquals(3, results);
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionFlagMultiline() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my' & chr(10) & '2cents' });
		variables.collection.insert({ 'test' = 'bulls' & chr(10) & '2bear' });
		variables.collection.insert({ 'test' = 'my' & chr(10) & '2monkies' });
		variables.collection.insert({ 'test' = 'my' & chr(10) & '4mOnkies' });
		variables.collection.insert({ 'test' = 'your' & chr(10) & '4monks' });
		
		results = variables.collection.count({ 'test' = variables.utility.regex('s$', 'm') });
		assertEquals(5, results);
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionString() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.count({ 'test' = variables.utility.regex('monk') });
		assertEquals(2, results);
	}
	
	public void function testSucceedWithQueryOperatorRegularExpressionWildcard() {
		var i = '';
		var results = '';
		
		variables.collection.insert({ 'test' = 'my2cents' });
		variables.collection.insert({ 'test' = 'bull2bear' });
		variables.collection.insert({ 'test' = 'my2monkies' });
		variables.collection.insert({ 'test' = 'my4mOnkies' });
		variables.collection.insert({ 'test' = 'your4monks' });
		
		results = variables.collection.count({ 'test' = variables.utility.regex('2.*s') });
		assertEquals(2, results);
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
		
		results = variables.collection.count({ 'test' = { '$size' = 3 } });
		
		assertEquals(3, results);
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorSliceWithNegative() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.count({ 'x' = { '$slice' = -3 } });
		
		assertEquals([1, 2, 3], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithPositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.count({ 'x' = { '$slice' = 3 } });
		
		assertEquals([-3, -2, -1], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithRangePositivePositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.count({ 'x' = { '$slice' = [2, 3] } });
		
		assertEquals([2, 3, 4], results[1].x);
	}
	
	public void function testSucceedWithQueryOperatorSliceWithRangeNegativePositive() {
		var results = '';
		
		variables.collection.insert({
			'test' = 'something',
			'x' = [ 1, 2, 3, 4, 5, -5, -4, -3, -2, -1 ]
		});
		
		results = variables.collection.count({ 'x' = { '$slice' = [-5, 4] } });
		assertEquals([-5, -4, -3, -2], results[1].x);
		
		results = variables.collection.count({ 'x' = { '$slice' = [-5, 20] } });
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
		
		results = variables.collection.count({ 'test' = 'blue' });
		
		assertEquals(2, results);
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
		
		results = variables.collection.count({ 'foo.color' = 'green'});
		
		assertEquals(2, results);
	}
	
	/** Not implemented as of mongodb java driver 1.2
	public void function testSucceedWithQueryOperatorWhereGreaterThan() {
		var i = '';
		var results = '';
		
		for(i = 1; i <= 10; i++) {
			variables.collection.insert({ 'test' = i });
		}
		
		results = variables.collection.count({ '$where' = 'test > 3' });
		
		assertEquals(6, results);
	}
	*/
	
	public void function testSucceedWithQuerySimple() {
		var results = '';
		
		variables.collection.insert({ 'test' = 'working' });
		variables.collection.insert({ 'test' = 'not working' });
		
		results = variables.collection.count({ 'test' = 'working' });
		
		assertEquals(1, results);
	}
}
