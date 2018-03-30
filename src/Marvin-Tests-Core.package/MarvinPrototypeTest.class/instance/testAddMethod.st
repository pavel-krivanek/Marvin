tests
testAddMethod

	object AddMethod: 'doIt ^ 3+4'.
	self assert: object doIt equals: 3+4.