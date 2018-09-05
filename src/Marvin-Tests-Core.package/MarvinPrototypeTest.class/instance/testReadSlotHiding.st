tests
testReadSlotHiding

	| parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

	parent _AddAssignSlot: #data value: 12.
	object _AddAssignSlot: #data value: 1.
	
	self assert: object data equals: 1.