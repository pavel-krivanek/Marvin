tests
testAccessFromParent

	parent _AddAssignSlot: #parentData value: 12.
	object _AddAssignSlot: #data value: 1.
	parent _AddMethod: 'doIt ^ self data + self parentData'.
	
	self assert: object doIt equals: 13.