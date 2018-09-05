tests
testResendReadSlot

	parent _AddReadSlot: #parentData value: 42.
	parent _AddReadSlot: #data value: 1.

	object _AddMethod: 'doIt ^ super parentData'.

	self assert: object doIt equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	