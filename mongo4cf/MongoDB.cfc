component {
	public component function init( string host = 'localhost', numeric port = 27017 ) {
		this.setHost(arguments.host);
		this.setPort(arguments.port);
		
		return this;
	}
	
	public string function getHost() {
		return variables.host;
	}
	
	public numeric function getPort() {
		return variables.port;
	}
	
	public void function setHost( string host ) {
		variables.host = arguments.host;
	}
	
	public void function setPort( numeric port ) {
		variables.port = arguments.port;
	}
}
