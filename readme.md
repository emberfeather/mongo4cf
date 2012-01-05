## Simple CFML Wrapper

Mongo4CF is a simple CFML wrapper for working with the official MongoDB Java driver.

## Getting Started

Start by following the [installation instructions][install] to get Mongo4CF running on your system.

Mongo4CF is designed to be used as an application singleton. When you create the Mongo object you establish the connection to the MongoDB server and the Java driver controls the connection pool. When your application is finished, close the connections to the MongoDB server.

Here is an example `Application.cfc`:

```
component {
	public boolean function onApplicationStart() {
		// Connect to the MongoDB server
		application.mongo = createObject('component', 'mongo4cf.mongo').init();
	}
	
	public void function onApplicationEnd(required struct applicationScope) {
		// Close the MongoDB connections
		arguments.applicationScope.mongo.close();
	}
}
```

And here is a simple example of connecting to a database collection, inserting a new record, and finding the record again:

```
db = application.mongo.getDB('mongo4cf_test');
collection = db.getCollection('testCollection');

collection.save({
	'name': 'Fred'
});

writeDump(collection.findOne());
```

For more information and usage see the [wiki][wiki].

[wiki]: https://github.com/emberfeather/mongo4cf/wiki
[install]: https://github.com/emberfeather/mongo4cf/wiki/install "Installation instructions"