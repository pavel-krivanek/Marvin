tests
testSuperInDelegation

	parent AddMethod: 'doIt ^ super'.

	self assert: object doIt equals: object.