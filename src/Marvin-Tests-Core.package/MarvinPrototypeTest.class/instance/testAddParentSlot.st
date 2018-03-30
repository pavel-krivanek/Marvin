tests
testAddParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	self should: [ object parent: parent ] raise: MessageNotUnderstood. 
	