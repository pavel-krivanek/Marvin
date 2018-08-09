running
testAddAssignSlotSlot

	object AddAssignSlot: #data value: 42.

	self checkArrayContent.
	
	self assert: object PrimitiveSize equals: 8.
		
	self assert: (object PrimitiveAt: 3) equals: nil.
	self assert: (object PrimitiveAt: 4) equals: 42.
	self assert: (object PrimitiveAt: 5) equals: #data:.
	self assert: (object PrimitiveAt: 6) equals: #data.
	self assert: (object PrimitiveAt: 7) equals: nil.
	self assert: (object PrimitiveAt: 8) equals: nil.

	
	
	
