component {
	public component function init( required any cursor ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.cursor = arguments.cursor;
		
		return this;
	}
	
	public component function addOption( required numeric option ) {
		return variables.cursor.addOption( javacast("int", arguments.option) );
		
		// Allow chaining
		return this;
	}
	
	public component function batchSize( required numeric n ) {
		return variables.cursor.batchSize( javacast("int", arguments.n) );
		
		// Allow chaining
		return this;
	}
	
	public component function copy() {
		// Allow chaining
		return createObject('component', 'mongo4cf.cursor').init(variables.cursor.copy());
	}
	
	public numeric function count() {
		return variables.cursor.count();
	}
	
	public struct function current() {
		return variables.utility.toCFType(variables.cursor.current());
	}
	
	public struct function explain() {
		return variables.utility.toCFType(variables.cursor.explain());
	}
	
	public struct function getKeysWanted() {
		return variables.utility.toCFType(variables.cursor.getKeysWanted());
	}
	
	public struct function getQuery() {
		return variables.utility.toCFType(variables.cursor.getQuery());
	}
	
	public array function getSizes() {
		return variables.cursor.getSizes();
	}
	
	public component function hint( required any index ) {
		if(isStruct(arguments.index)) {
			variables.cursor.hint( variables.utility.createBasicDBObject( duplicate( arguments.index ) ) );
		} else {
			variables.cursor.hint( index );
		}
		
		// Allow chaining
		return this;
	}
	
	public boolean function hasNext() {
		return variables.cursor.hasNext();
	}
	
	public numeric function length() {
		return variables.cursor.length();
	}
	
	public component function limit( required numeric n ) {
		variables.cursor.limit( javacast('int', arguments.n) );
		
		// Allow chaining
		return this;
	}
	
	public numeric function next() {
		return variables.utility.toCFType(variables.cursor.next());
	}
	
	public numeric function numGetMores() {
		return variables.cursor.numGetMores();
	}
	
	public numeric function numSeen() {
		return variables.cursor.numSeen();
	}
	
	public numeric function size() {
		return variables.cursor.size();
	}
	
	public component function skip( required numeric n ) {
		variables.cursor.skip( javacast('int', arguments.n) );
		
		// Allow chaining
		return this;
	}
	
	public component function snapshot( required numeric n ) {
		variables.cursor.snapshot();
		
		// Allow chaining
		return this;
	}
	
	public component function sort( struct orderBy = {} ) {
		variables.cursor.sort( variables.utility.createBasicDBObject( duplicate( arguments.orderBy ) ) );
		
		// Allow chaining
		return this;
	}
	
	public array function toArray() {
		var results = [];
		
		while(variables.cursor.hasNext()) {
			arrayAppend(results, variables.utility.toCFType(variables.cursor.next()));
		}
		
		return results;
	}
	
	public string function _toString() {
		return serializeJson(this.toArray());
	}
	
	public any function _getRaw() {
		return variables.cursor;
	}
}
