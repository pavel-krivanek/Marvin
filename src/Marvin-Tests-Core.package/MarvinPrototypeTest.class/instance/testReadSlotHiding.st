tests
testReadSlotHiding

	| parent |
	
	parent := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

	parent AddAssignSlot: #data value: 12.
	object AddAssignSlot: #data value: 1.
	
	self assert: object data equals: 1.