running
setUp

	super setUp.
	
	object := MarvinPrototype new: 2.
	object _PrimitiveAt: 1 put: 1.
	object _PrimitiveAt: 2 put: 2.