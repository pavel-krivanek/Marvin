tests
testSlotHiding

	parent _AddAssignSlot: #data value: 12.
	object _AddAssignSlot: #data value: 1.
	parent _AddMethod: 'doIt ^ self data'.
	
	self assert: object doIt equals: 1.