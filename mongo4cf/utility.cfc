component {
	public component function init() {
		variables.factory = createObject('component', 'mongo4cf.factory').init();
		variables.pattern = createObject('java', 'java.util.regex.Pattern');
		variables.oro = getJavaObject('org.apache.oro.text.regex.Perl5Compiler').init();
		
		return this;
	}
	
	/**
	 * Used to recursively create a java BasicDBObject from a CF struct
	 */
	public any function createBasicDBObject(struct doc = {}) {
		var dbObject = getJavaObject('com.mongodb.BasicDBObject').init();
		var key = '';
		
		for( key in arguments.doc ) {
			if( key == '_id' && isSimpleValue(arguments.doc[key]) && len(arguments.doc[key]) == 24 ) {
				// Automatically convert an _id field to an ObjectID
				dbObject.append(key, objectID(arguments.doc[key]));
			} else if( isStruct(arguments.doc[key]) ) {
				// Handle nested documents
				dbObject.append(key, createBasicDBObject(arguments.doc[key]));
			} else if( isObject(arguments.doc[key]) ) {
				// Allow for java objects
				dbObject.append(key, arguments.doc[key]);
			} else {
				// Convert the value to a java object when necessary
				dbObject.append(key, toJavaType(arguments.doc[key]));
			}
		}
		
		return dbObject;
	}
	
	/**
	 * Shortcut for creating the ObjectID object
	 */
	public any function objectID(string id) {
		return getJavaObject('org.bson.types.ObjectId').init(id);
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
	
	public string function reescape( required string expression ) {
		return variables.oro.quotemeta(arguments.expression);
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