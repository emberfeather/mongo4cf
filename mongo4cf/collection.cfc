component {
	public component function init( required any collection ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.collection = arguments.collection;
		
		return this;
	}
	
	public void function createIndex( required struct index ) {
		variables.collection.createIndex( variables.utility.createBasicDBObject( duplicate( arguments.index ) ) );
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
	
	public void function dropIndexes() {
		variables.collection.dropIndexes();
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
	
	public numeric function getCount() {
		return variables.collection.getCount();
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
	
	public any function _getRaw() {
		return variables.collection;
	}
}
