component extends="test.base" {
	public void function setup() {
		super.setup('collection_update');
	}
	
	public void function testSucceedOperatorAddToSetToArrayExisting() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$addToSet' = { 'x' = 4 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 1, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorAddToSetToArrayNotExisting() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$addToSet' = { 'x' = 6 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 6, result.x[2] );
		assertEquals( 2, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorAddToSetToArrayWithEach() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$addToSet' = { 'x' = { '$each' = [ 3, 4, 5, 7 ] } } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 3, result.x[2] );
		assertEquals( 5, result.x[3] );
		assertEquals( 7, result.x[4] );
		assertEquals( 4, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorAddToSetToNonArray() {
		variables.collection.insert({ '_id' = 1, 'x' = 'test' });
		
		variables.collection.update({ '_id' = 1 }, { '$addToSet' = { 'x' = 6 } });
		
		// Doesn't `throw` an error but it doesn't update the record
		assertEquals( 'test', variables.collection.findOne().x );
	}
	
	public void function testSucceedOperatorAddToSetToNotPresent() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1 });
		
		variables.collection.update({ '_id' = 1 }, { '$addToSet' = { 'x' = 6 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 6, result.x[1] );
		assertEquals( 1, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorInc() {
		variables.collection.insert({ '_id' = 1, 'x' = 4 });
		
		variables.collection.update({ '_id' = 1 }, { '$inc' = { 'x' = 3 } });
		
		assertEquals( 7, variables.collection.findOne().x );
	}
	
	public void function testSucceedOperatorPopNegative() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4, 5, 6 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$pop' = { 'x' = -1 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 5, result.x[1] );
		assertEquals( 6, result.x[2] );
		assertEquals( 2, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorPopPositive() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4, 5, 6 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$pop' = { 'x' = 1 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 5, result.x[2] );
		assertEquals( 2, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorPositional() {
		var result = '';
		
		variables.collection.insert({ 'title' = 'ABC', 'comments' = [ { 'by' = 'joe', 'votes' = 3 }, { 'by' = 'jane', 'votes' = 7 } ] });
		
		variables.collection.update({ 'comments.by' ='joe' }, { '$inc' = { 'comments.$.votes' = 1 } }, false, true);
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.comments[1].votes );
	}
	
	public void function testSucceedOperatorPositionalFirstOnly() {
		var result = '';
		
		variables.collection.insert({ 'x' = [ 1, 2, 3, 2 ] });
		
		variables.collection.update({ 'x' = 2}, { '$inc' = { 'x.$' = 1 } }, false, true);
		
		result = variables.collection.findOne();
		
		assertEquals( 1, result.x[1] );
		assertEquals( 3, result.x[2] );
		assertEquals( 3, result.x[3] );
		assertEquals( 2, result.x[4] );
	}
	
	public void function testSucceedOperatorPull() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4, 5, 4, 6, 4, 7 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$pull' = { 'x' = 4 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 5, result.x[1] );
		assertEquals( 6, result.x[2] );
		assertEquals( 7, result.x[3] );
		assertEquals( 3, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorPullAll() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4, 5, 4, 6, 4, 7 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$pullAll' = { 'x' = [ 4, 6 ] } });
		
		result = variables.collection.findOne();
		
		assertEquals( 5, result.x[1] );
		assertEquals( 7, result.x[2] );
		assertEquals( 2, arrayLen(result.x) );
	}
	
	public void function testSucceedOperatorPushAllToArray() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$pushAll' = { 'x' = [ 4, 6, 8, 10 ] } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 4, result.x[2] );
		assertEquals( 6, result.x[3] );
		assertEquals( 8, result.x[4] );
		assertEquals( 10, result.x[5] );
	}
	
	public void function testSucceedOperatorPushAllToNonArray() {
		variables.collection.insert({ '_id' = 1, 'x' = 'test' });
		
		variables.collection.update({ '_id' = 1 }, { '$pushAll' = { 'x' = [ 6, 8, 10 ] } });
		
		// Doesn't `throw` an error but it doesn't update the record
		assertEquals( 'test', variables.collection.findOne().x );
	}
	
	public void function testSucceedOperatorPushAllToNotPresent() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1 });
		
		variables.collection.update({ '_id' = 1 }, { '$pushAll' = { 'x' = [ 6, 8, 10 ] } });
		
		result = variables.collection.findOne();
		
		assertEquals( 6, result.x[1] );
		assertEquals( 8, result.x[2] );
		assertEquals( 10, result.x[3] );
	}
	
	public void function testSucceedOperatorPushToArray() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ 4 ] });
		
		variables.collection.update({ '_id' = 1 }, { '$push' = { 'x' = 6 } });
		
		result = variables.collection.findOne();
		
		assertEquals( 4, result.x[1] );
		assertEquals( 6, result.x[2] );
	}
	
	public void function testSucceedOperatorPushToArrayComplex() {
		var result = '';
		
		variables.collection.insert({ '_id' = 1, 'x' = [ { 'y' = 16 } ] });
		
		variables.collection.update({ '_id' = 1 }, { '$push' = { 'x' = { 'y' = 25 } } });
		
		result = variables.collection.findOne();
		
		assertEquals( 16, result.x[1].y );
		assertEquals( 25, result.x[2].y );
	}
	
	public void function testSucceedOperatorPushToNonArray() {
		variables.collection.insert({ '_id' = 1, 'x' = 'test' });
		
		variables.collection.update({ '_id' = 1 }, { '$push' = { 'x' = 6 } });
		
		// Doesn't `throw` an error but it doesn't update the record
		assertEquals( 'test', variables.collection.findOne().x );
	}
	
	public void function testSucceedOperatorPushToNotPresent() {
		variables.collection.insert({ '_id' = 1 });
		
		variables.collection.update({ '_id' = 1 }, { '$push' = { 'x' = 6 } });
		
		assertEquals( 6, variables.collection.findOne().x[1] );
	}
	
	public void function testSucceedOperatorSet() {
		variables.collection.insert({ '_id' = 1, 'x' = 4 });
		
		variables.collection.update({ '_id' = 1 }, { '$set' = { 'x' = 15 } });
		
		assertEquals( 15, variables.collection.findOne().x );
	}
	
	public void function testSucceedOperatorUnset() {
		variables.collection.insert({ '_id' = 1, 'x' = 4 });
		
		variables.collection.update({ '_id' = 1 }, { '$unset' = { 'x' = 1 } });
		
		assertFalse( structKeyExists(variables.collection.findOne(), 'x' ) );
	}
	
	public void function testSucceedWithID() {
		variables.collection.insert({ '_id' = 1, 'test' = 'is it?' });
		
		assertEquals( 'is it?', variables.collection.findOne().test );
		
		variables.collection.update({ '_id' = 1 }, { 'test' = 'working' });
		
		assertEquals( 'working', variables.collection.findOne().test );
	}
	
	public void function testSucceedWithMultiFalse() {
		variables.collection.insert({ '_id' = 1, 'test' = 'is it?' });
		variables.collection.insert({ '_id' = 2, 'test' = 'is it?' });
		
		assertEquals( 'is it?', variables.collection.find({ '_id' = 1 }).toArray()[1].test );
		assertEquals( 'is it?', variables.collection.find({ '_id' = 2 }).toArray()[1].test );
		
		variables.collection.update({ 'test' = 'is it?' }, { 'test' = 'working' });
		
		// The first found should be changed only
		assertEquals( 'working', variables.collection.find({ '_id' = 1 }).toArray()[1].test );
		assertEquals( 'is it?', variables.collection.find({ '_id' = 2 }).toArray()[1].test );
	}
	
	public void function testSucceedWithMultiTrue() {
		var doc = '';
		var results = '';
		
		variables.collection.insert({ 'x' = 4, 'y' = 3 });
		variables.collection.insert({ 'x' = 5, 'y' = 5 });
		variables.collection.insert({ 'x' = 4, 'y' = 4 });
		
		variables.collection.update( { 'x' = 4 }, { '$set' = { 'y' = 5 } }, false, true );
		
		assertEquals( 3, variables.collection.getCount() );
		
		results = variables.collection.find().toArray();
		
		for(doc in results) {
			assertEquals(5, doc.y);
		}
	}
	
	public void function testSucceedWithUpsert() {
		variables.collection.update({ 'page' = '/' }, { '$inc' = { 'count' = 1 } }, true, false);
		variables.collection.update({ 'page' = '/' }, { '$inc' = { 'count' = 1 } }, true, false);
		
		assertEquals( 1, variables.collection.getCount() );
		assertEquals( 2, variables.collection.findOne().count );
	}
	
	public void function testSucceedWithUpsertModifiers() {
		var result = '';
		
		variables.collection.update( { 'name' = 'Joe' }, { '$inc' = { 'x' = 1, 'y' = 2 } }, true, false );
		
		result = variables.collection.findOne();
		
		assertEquals( 1, result.x );
		assertEquals( 2, result.y );
	}
}
