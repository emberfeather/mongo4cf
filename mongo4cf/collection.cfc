component {
	public component function init( required any collection ) {
		variables.utility = createObject('component', 'mongo4cf.utility').init();
		variables.collection = arguments.collection;
		
		return this;
	}
	
	public void function drop() {
		variables.collection.drop();
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
	
	public array function findAsArray(struct doc = {}, struct keys = {}, numeric numToSkip = 0, numeric batchSize = 0) {
		return this.find(argumentCollection = arguments).toArray();
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
