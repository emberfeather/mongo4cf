component extends="test.base" {
	public void function setup() {}
	
	public void function testSucceedWithName() {
		assertEquals('mongo4cf_test', variables.db.getName());
	}
}
