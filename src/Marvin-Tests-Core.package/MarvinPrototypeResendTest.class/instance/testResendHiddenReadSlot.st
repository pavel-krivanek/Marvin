tests
testResendHiddenReadSlot

	parent _AddReadSlot: #data value: 42.
	parent _AddReadSlot: #data value: 1.

	object _AddMethod: 'doIt ^ super data'.

	self assert: object data equals: 42.
	