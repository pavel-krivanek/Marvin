tests
testSelfInDelegation

	parent _AddMethod: 'doIt ^ self'.

	self assert: object doIt equals: object.