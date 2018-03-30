tests
testAddParentSlot

	| object parent |
	
	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	self should: [ object parent: parent ] raise: MarvinSlotNotFound. 
	