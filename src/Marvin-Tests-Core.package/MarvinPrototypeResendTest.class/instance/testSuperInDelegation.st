tests
testSuperInDelegation

	parent _AddMethod: 'doIt ^ super'.

	self assert: object doIt equals: object.