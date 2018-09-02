running
testRevertInjection

	object := MarvinPrototype inject: 1@2.
	object AddAssignSlot: #y value: 5.
	
	self assert: object class equals: Point.
	self assert: object y equals: 5.
	
	object RevertInjection.
	
	self assert: object class equals: Point.
	self assert: object y equals: 2.
