tests
testAddReadWriteParentSlot

	| object parent parent2 |
	
	parent := MarvinPrototype new.
	parent2 := MarvinPrototype new.
	object := MarvinPrototype new.
	object AddReadWriteParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	object parent: parent2.
	self assert: object parent equals: parent2.
	