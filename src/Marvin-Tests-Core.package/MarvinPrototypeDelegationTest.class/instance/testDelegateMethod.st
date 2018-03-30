tests
testDelegateMethod

	parent AddMethod: 'doIt ^ 3+4'.

	self assert: object doIt equals: 3+4.