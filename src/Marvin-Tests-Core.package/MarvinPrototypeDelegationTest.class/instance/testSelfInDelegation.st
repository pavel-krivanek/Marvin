tests
testSelfInDelegation

	parent AddMethod: 'doIt ^ self'.

	self assert: object doIt equals: object.