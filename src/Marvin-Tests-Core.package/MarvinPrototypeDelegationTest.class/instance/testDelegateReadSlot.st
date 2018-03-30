tests
testDelegateReadSlot

	parent AddReadSlot: #data value: 42.

	self assert: object data equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	