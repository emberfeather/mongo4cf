component {
	public component function init() {
		variables.factory = createObject('component', 'mongo4cf.factory').init();
		variables.pattern = createObject('java', 'java.util.regex.Pattern');
		
		return this;
	}
	
	/**
	 * Used to recursively create a java BasicDBObject from a CF struct
	 */
	public any function createBasicDBObject(struct doc = {}) {
		var dbObject = getJavaObject('com.mongodb.BasicDBObject').init();
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
	
	public any function getJavaObject( required string definition ) {
		return variables.factory.getJavaObject(arguments.definition);
	}
	
	public any function regex( required string expression, string modifiers = '' ) {
		var flags = 0;
		
		// Check for modifiers
		if(find('i', arguments.modifiers)) {
			flags = bitOr( flags, variables.pattern.CASE_INSENSITIVE );
		}
		
		if(find('m', arguments.modifiers)) {
			flags = bitOr( flags, variables.pattern.MULTILINE );
		}
		
		if(find('x', arguments.modifiers)) {
			flags = bitOr( flags, variables.pattern.COMMENTS );
		}
		
		return variables.pattern.compile( arguments.expression, flags );
	}
	
	public any function toCFType(required any value ) {
		var i = '';
		var keys = '';
		var temp = '';
		
		if( isNull(arguments.value) ) {
			return {};
		}
		
		// Look for nested documents
		if( isStruct(arguments.value) ) {
			keys = arguments.value.keySet().toArray();
			temp = {};
			
			for( i = 1; i <= arrayLen(keys); i++ ) {
				if( !isNull(arguments.value.get(keys[i]) )) {
					temp[keys[i]] = toCFType(arguments.value[keys[i]]);
				}
			}
			
			return temp;
		}
		
		// Look for arrays
		if( isArray(arguments.value) ) {
			temp = [];
			
			for( i = 1; i <= arrayLen(arguments.value); i++ ) {
				temp[i] = toCFType(arguments.value[i]);
			}
			
			return temp;
		}
		
		// Check for native java objects
		if( isObject(arguments.value) ) {
			return arguments.value.toString();
		}
		
		return arguments.value;
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
		
		if( isDate(value) ) {
			return parseDateTime(value);
		}
		
		return value;
	}
}