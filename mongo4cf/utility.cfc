component {
	public component function init() {
		return this;
	}
	
	/**
	 * Used to recursively create a java BasicDBObject from a CF struct
	 */
	public any function createBasicDBObject(struct doc = {}) {
		var dbObject = createObject('java', 'com.mongodb.BasicDBObject', '/mongo4cf/lib/mongo.jar').init();
		var key = '';
		
		for( key in arguments.doc ) {
			// Handle nested documents
			if( isStruct(arguments.doc[key]) ) {
				dbObject.append(key, createBasicDBObject(arguments.doc[key]));
			} else {
				dbObject.append(key, toJavaType(arguments.doc[key]));
			}
		}
		
		return dbObject;
	}
	
	public any function toCFType(required any value ) {
		var i = '';
		var keys = '';
		var temp = '';
		
		// Look for nested documents
		if( isStruct(arguments.value) ) {
			keys = arguments.value.keySet().toArray();
			temp = {};
			
			for( i = 1; i <= arrayLen(keys); i++ ) {
				temp[keys[i]] = toCFType(arguments.value[keys[i]]);
			}
			
			return temp;
		}
		
		if( isObject(value) ) {
			return value.toString();
		}
		
		return value;
	}
	
	public function toJavaType(required any value ) {
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
}