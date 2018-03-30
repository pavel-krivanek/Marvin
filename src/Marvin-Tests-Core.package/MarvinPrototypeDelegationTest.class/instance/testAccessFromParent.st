tests
testAccessFromParent

	parent AddAssignSlot: #parentData value: 12.
	object AddAssignSlot: #data value: 1.
	parent AddMethod: 'doIt ^ self data + self parentData'.
	
	self assert: object doIt equals: 13.