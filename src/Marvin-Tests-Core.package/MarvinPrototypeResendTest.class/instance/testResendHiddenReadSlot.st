tests
testResendHiddenReadSlot

	parent AddReadSlot: #data value: 42.
	parent AddReadSlot: #data value: 1.

	object AddMethod: 'doIt ^ super data'.

	self assert: object data equals: 42.
	