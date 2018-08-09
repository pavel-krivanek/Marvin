running
setUp

	super setUp.
	
	object := MarvinPrototype new: 2.
	object PrimitiveAt: 1 put: 1.
	object PrimitiveAt: 2 put: 2.