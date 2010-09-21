component extends="test.base" {
	public void function setup() {
		super.setup('collection_distinct');
	}
	
	public void function testSucceedWithRepeatedValues() {
		// Insert some repeating values
		variables.collection.insert({ 'test': 'value1' });
		variables.collection.insert({ 'test': 'value1' });
		variables.collection.insert({ 'test': 'value1' });
		variables.collection.insert({ 'test': 'value2' });
		variables.collection.insert({ 'test': 'value2' });
		variables.collection.insert({ 'test': 'value2' });
		variables.collection.insert({ 'test': 'value2' });
		variables.collection.insert({ 'test': 'value2' });
		variables.collection.insert({ 'test': 'value3' });
		variables.collection.insert({ 'test': 'value3' });
		variables.collection.insert({ 'test': 'value3' });
		variables.collection.insert({ 'test': 'value3' });
		
		// Test against all of the records, including ones with duplicates
		assertEquals(3, arrayLen(variables.collection.distinct('test')));
	}
	
	public void function testSucceedWithRepeatedValuesOnQuery() {
		// Insert some repeating values
		variables.collection.insert({ 'test': 'value1', 'x': 1 });
		variables.collection.insert({ 'test': 'value1', 'x': 1 });
		variables.collection.insert({ 'test': 'value1', 'x': 1 });
		variables.collection.insert({ 'test': 'value2', 'x': 2 });
		variables.collection.insert({ 'test': 'value2', 'x': 2 });
		variables.collection.insert({ 'test': 'value2', 'x': 2 });
		variables.collection.insert({ 'test': 'value2', 'x': 2 });
		variables.collection.insert({ 'test': 'value3', 'x': 3 });
		variables.collection.insert({ 'test': 'value3', 'x': 3 });
		variables.collection.insert({ 'test': 'value3', 'x': 3 });
		variables.collection.insert({ 'test': 'value3', 'x': 3 });
		variables.collection.insert({ 'test': 'value3', 'x': 3 });
		
		// Test against a query that only matches part of the records
		assertEquals(2, arrayLen(variables.collection.distinct('test', { 'x': { '$gt': 1 } })));
	}
}
