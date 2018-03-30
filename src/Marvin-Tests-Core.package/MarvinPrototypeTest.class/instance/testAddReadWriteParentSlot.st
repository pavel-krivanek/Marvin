tests
testAddReadWriteParentSlot

	|  parent parent2 |
	
	parent := MarvinPrototype new.
	parent2 := MarvinPrototype new.
	object AddReadWriteParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	self assert: (object parent: parent2) equals: object.
	self assert: object parent equals: parent2.
	