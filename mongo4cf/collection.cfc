component {
	public component function init( required any collection ) {
		variables.collection = arguments.collection;
		
		return this;
	}
	
	public any function _getRaw() {
		return variables.collection;
	}
}
