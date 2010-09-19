component {
	public component function init( required component db, required any collection ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.db = arguments.db;
		variables.collection = arguments.collection;
		
		return this;
	}
	
	public void function createIndex( required struct index ) {
		variables.collection.createIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ) );
	}
	
	public array function distinct( required string key, struct query ) {
		if( structKeyExists(arguments, 'query') ) {
			return variables.collection.distinct( arguments.key, variables.utility.createBasicDBObject( duplicate( arguments.query ) ) ).toArray();
		}
		
		return variables.collection.distinct( arguments.key ).toArray();
	}
	
	public void function drop() {
		variables.collection.drop();
	}
	
	public void function dropIndex( required any index ) {
		if(isStruct(arguments.index)) {
			variables.collection.dropIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ) );
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
					variables.utility.createBasicDBObject( duplicate( arguments.index ) ),
					variables.utility.createBasicDBObject( duplicate( arguments.options ) )
				);
			} else if(structKeyExists(arguments, 'unique')) {
				variables.collection.ensureIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ), arguments.options, arguments.unique );
			} else {
				variables.collection.ensureIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ), arguments.options );
			}
		} else {
			variables.collection.ensureIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ) );
		}
	}
	
	public component function find(struct doc = {}, struct keys = {}, numeric numToSkip = 0, numeric batchSize = 0) {
		var cursor = '';
		
		// Find the generated db object
		cursor = createObject('component', 'mongo4cf.cursor').init(
			variables.collection.find(
				variables.utility.createBasicDBObject( duplicate( arguments.doc ) ),
				variables.utility.createBasicDBObject( duplicate( arguments.keys ) ),
				arguments.numToSkip,
				arguments.batchSize
			)
		);
		
		return cursor;
	}
	
	public struct function findOne() {
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
					variables.utility.createBasicDBObject( duplicate( arguments.index ) ),
					variables.utility.createBasicDBObject( duplicate( arguments.fields ) ),
					arguments.limit,
					arguments.skip
				);
			}
			
			if(structKeyExists(arguments, 'fields')) {
				return variables.collection.getCount(
					variables.utility.createBasicDBObject( duplicate( arguments.index ) ),
					variables.utility.createBasicDBObject( duplicate( arguments.fields ) )
				);
			}
			
			return variables.collection.getCount( variables.utility.createBasicDBObject( duplicate( arguments.query ) ) );
		}
		
		return variables.collection.getCount();
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
		
		for(i = 1; i <= arrayLen(arguments.docs); i++) {
			arrayAppend(dbObjects, variables.utility.createBasicDBObject( duplicate( arguments.docs[i] ) ))
		}
		
		// Insert the generated db object
		return variables.collection.insert( dbObjects );
	}
	
	public component function rename( required string name ) {
		return variables.collection.rename( arguments.name );
		
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
