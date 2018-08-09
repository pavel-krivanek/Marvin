running
testAddAssignSlotSlot

	object AddAssignSlot: #data value: 42.

	self checkArrayContent.
	
	self assert: object primitiveSize equals: 8.
		
	self assert: (object at: 3) equals: nil.
	self assert: (object at: 4) equals: 42.
	self assert: (object at: 5) equals: #data:.
	self assert: (object at: 6) equals: #data.
	self assert: (object at: 7) equals: nil.
	self assert: (object at: 8) equals: nil.

	
	
	
