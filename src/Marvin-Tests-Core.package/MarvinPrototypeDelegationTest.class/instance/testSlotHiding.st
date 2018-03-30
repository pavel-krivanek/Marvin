tests
testSlotHiding

	parent AddAssignSlot: #data value: 12.
	object AddAssignSlot: #data value: 1.
	parent AddMethod: 'doIt ^ self data'.
	
	self assert: object doIt equals: 1.