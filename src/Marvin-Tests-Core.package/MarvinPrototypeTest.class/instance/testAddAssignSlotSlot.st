tests
testAddAssignSlotSlot

	object _AddAssignSlot: #data value: 42.

	self assert: object data equals: 42.
	self assert: (object data: 12) equals: object.
	self assert: object data equals: 12.