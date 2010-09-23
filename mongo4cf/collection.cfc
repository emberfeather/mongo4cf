component {
	public component function init( required component db, required any collection ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.db = arguments.db;
		variables.collection = arguments.collection;
		
		return this;
	}
	
	public void function createIndex( required struct index ) {
		variables.collection.createIndex( variables.utility.createBasicDBObject( arguments.index ) );
	}
	
	public array function distinct( required string key, struct query ) {
		if( structKeyExists(arguments, 'query') ) {
			return variables.collection.distinct( arguments.key, variables.utility.createBasicDBObject( arguments.query ) ).toArray();
		}
		
		return variables.collection.distinct( arguments.key ).toArray();
	}
	
	public void function drop() {
		variables.collection.drop();
	}
	
	public void function dropIndex( required any index ) {
		if(isStruct(arguments.index)) {
			variables.collection.dropIndex( variables.utility.createBasicDBObject( arguments.index ) );
		} else {
			variables.collection.dropIndex( index );
		}
	}
	
	public void function dropIndexes( string name ) {
		if( structKeyExists(arguments, 'name') ) {
			variables.collection.dropIndexes( arguments.name );
		} else {
			variables.collection.dropIndexes();
		}
	}
	
	public void function ensureIndex( required any index, any options, boolean unique ) {
		if(structKeyExists(arguments, 'options')) {
			if(isStruct(arguments.options) and !structIsEmpty(arguments.options)) {
				variables.collection.ensureIndex(
					variables.utility.createBasicDBObject( arguments.index ),
					variables.utility.createBasicDBObject( arguments.options )
				);
			} else if(structKeyExists(arguments, 'unique')) {
				variables.collection.ensureIndex( variables.utility.createBasicDBObject( arguments.index ), arguments.options, arguments.unique );
			} else {
				variables.collection.ensureIndex( variables.utility.createBasicDBObject( arguments.index ), arguments.options );
			}
		} else {
			variables.collection.ensureIndex( variables.utility.createBasicDBObject( arguments.index ) );
		}
	}
	
	public boolean function equals( required component otherCollection ) {
		return variables.collection.equals(arguments.otherCollection._getRaw());
	}
	
	public component function find(struct doc, struct keys, numeric numToSkip, numeric batchSize, struct options) {
		var results = '';
		
		// Find the documents
		if(structKeyExists(arguments, 'doc')) {
			if(structKeyExists(arguments, 'keys')) {
				if(structKeyExists(arguments, 'numToSkip') and structKeyExists(arguments, 'batchSize')) {
					if(structKeyExists(arguments, 'options')) {
						results = variables.collection.find(
							variables.utility.createBasicDBObject( arguments.doc ),
							variables.utility.createBasicDBObject( arguments.keys ),
							arguments.numToSkip,
							arguments.batchSize,
							variables.utility.createBasicDBObject( arguments.options )
						);
					} else {
						results = variables.collection.find(
							variables.utility.createBasicDBObject( arguments.doc ),
							variables.utility.createBasicDBObject( arguments.keys ),
							arguments.numToSkip,
							arguments.batchSize
						);
					}
				} else {
					results = variables.collection.find(
						variables.utility.createBasicDBObject( arguments.doc ),
						variables.utility.createBasicDBObject( arguments.keys )
					);
				}
			} else {
				results = variables.collection.find( variables.utility.createBasicDBObject( arguments.doc ) );
			}
		} else {
			results = variables.collection.find();
		}
		
		return createObject('component', 'mongo4cf.cursor').init( results );
	}
	
	public struct function findOne( any obj, struct fields ) {
		if(structKeyExists(arguments, 'obj') && structKeyExists(arguments, 'fields')) {
			if(isStruct(arguments.obj)) {
				return variables.utility.toCFType(variables.collection.findOne( variables.utility.createBasicDBObject( arguments.obj ), variables.utility.createBasicDBObject( arguments.fields ) ));
			}
			
			return variables.utility.toCFType(variables.collection.findOne( arguments.obj, variables.utility.createBasicDBObject( arguments.fields ) ));
		} else if(structKeyExists(arguments, 'obj')) {
			if(isStruct(arguments.obj)) {
				return variables.utility.toCFType(variables.collection.findOne( variables.utility.createBasicDBObject( arguments.obj ) ) );
			}
			
			return variables.utility.toCFType(variables.collection.findOne( arguments.obj ) );
		}
		
		return variables.utility.toCFType(variables.collection.findOne());
	}
	
	public component function getDB() {
		return variables.db;
	}
	
	public string function getFullName() {
		return variables.collection.getFullName();
	}
	
	public numeric function getCount( struct query, struct fields, numeric limit, numeric skip ) {
		if(structKeyExists(arguments, 'query')) {
			if(structKeyExists(arguments, 'limit') && structKeyExists(arguments, 'skip')) {
				return variables.collection.getCount(
					variables.utility.createBasicDBObject( arguments.index ),
					variables.utility.createBasicDBObject( arguments.fields ),
					arguments.limit,
					arguments.skip
				);
			}
			
			if(structKeyExists(arguments, 'fields')) {
				return variables.collection.getCount(
					variables.utility.createBasicDBObject( arguments.index ),
					variables.utility.createBasicDBObject( arguments.fields )
				);
			}
			
			return variables.collection.getCount( variables.utility.createBasicDBObject( arguments.query ) );
		}
		
		return variables.collection.getCount();
	}
	
	public array function getIndexInfo() {
		return variables.utility.toCFType(variables.collection.getIndexInfo());
	}
	
	public string function getName() {
		return variables.collection.getName();
	}
	
	public any function insert(required any docs) {
		var dbObjects = [];
		var i = '';
		
		if( !isArray(arguments.docs) ) {
			arguments.docs = [ arguments.docs ];
		}
		
		// Allow to pass multiple docs as separate arguments
		if(arrayLen(arguments) > 1) {
			for(i = 2; i <= arrayLen(arguments); i++) {
				arrayAppend(arguments.docs, arguments[i]);
			}
		}
		
		for(i = 1; i <= arrayLen(arguments.docs); i++) {
			arrayAppend(dbObjects, variables.utility.createBasicDBObject( arguments.docs[i] ))
		}
		
		// Insert the generated db object
		return variables.collection.insert( dbObjects );
	}
	
	public any function regex( required string expression, string modifiers = '' ) {
		return variables.utility.regex( argumentCollection = arguments );
	}
	
	public void function remove( required struct doc ) {
		variables.collection.remove( variables.utility.createBasicDBObject( arguments.doc ) );
	}
	
	public component function rename( required string name ) {
		variables.collection.rename( arguments.name );
		
		// Allow chaining
		return this;
	}
	
	public string function _toString() {
		return variables.collection.toString();
	}
	
	public any function _getRaw() {
		return variables.collection;
	}
}
