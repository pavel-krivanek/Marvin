running
setUp

	super setUp.
	
	object := MarvinPrototype new: 2.
	object at: 1 put: 1.
	object at: 2 put: 2.