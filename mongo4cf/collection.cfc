component {
	public component function init( required any collection ) {
		variables.collection = arguments.collection;
		
		return this;
	}
	
	/**
	 * Used to recursively create a java BasicDBObject
	 */
	private any function createDBObject(struct doc = {}) {
		var dbObject = createObject('java', 'com.mongodb.BasicDBObject', '/mongo4cf/lib/mongo.jar').init();
		var key = '';
		
		for( key in arguments.doc ) {
			// Handle nested documents
			if( isStruct(arguments.doc[key]) ) {
				dbObject.append(key, createDBObject(arguments.doc[key]));
			} else {
				dbObject.append(key, _toJavaType(arguments.doc[key]));
			}
		}
		
		return dbObject;
	}
	
	public void function drop() {
		variables.collection.drop();
	}
	
	public array function find(required struct doc) {
		var cursor = findAsCursor(arguments.doc);
		var results = [];
		
		while(cursor.hasNext()) {
			arrayAppend(results, _toCFType(cursor.next()));
		}
		
		return results;
	}
	
	public any function findAsArray(required struct doc) {
		return findAsCursor(arguments.doc).toArray();
	}
	
	public any function findAsCursor(required struct doc) {
		// Find the generated db object
		return variables.collection.find( createDBObject( duplicate( arguments.doc ) ) );
	}
	
	public struct function findOne() {
		return _toCFType(variables.collection.findOne());
	}
	
	public any function insert(required any docs) {
		var dbObjects = [];
		var i = '';
		
		if( !isArray(arguments.docs) ) {
			arguments.docs = [ arguments.docs ];
		}
		
		for(i = 1; i <= arrayLen(arguments.docs); i++) {
			arrayAppend(dbObjects, createDBObject( duplicate( arguments.docs[i] ) ))
		}
		
		// Insert the generated db object
		return variables.collection.insert( dbObjects );
	}
	
	private function _toCFType(required any value ) {
		var i = '';
		var keys = '';
		var temp = '';
		
		// Look for nested documents
		if( isStruct(arguments.value) ) {
			keys = arguments.value.keySet().toArray();
			
			for( i = 1; i <= arrayLen(keys); i++ ) {
				arguments.value[keys[i]] = _toCFType(arguments.value[keys[i]]);
			}
			
			return arguments.value;
		}
		
		if( isObject(value) ) {
			return value.toString();
		}
		
		return value;
	}
	
	private function _toJavaType(required any value ) {
		if( not isNumeric(value) AND isBoolean(value) ) {
			return javacast("boolean", value);
		}
		
		if( isNumeric(value) and find(".",value) ) {
			return javacast("double", value);
		}
		
		if( isNumeric(value) ) {
			return javacast("long", value);
		}
		
		return value;
	}
	
	public any function _getRaw() {
		return variables.collection;
	}
}
