tests
testResendReadSlot

	parent AddReadSlot: #parentData value: 42.
	parent AddReadSlot: #data value: 1.

	object AddMethod: 'doIt ^ super parentData'.

	self assert: object doIt equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	