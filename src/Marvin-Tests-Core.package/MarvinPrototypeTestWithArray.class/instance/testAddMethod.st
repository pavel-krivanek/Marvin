running
testAddMethod

	object AddMethod: 'doIt ^ 3+4'.

	self checkArrayContent.
	
	self assert: object primitiveSize equals: 7.
		
	self assert: (object at: 3) equals: nil.
	self assert: (object at: 4) equals: nil.
	self assert: (object at: 5) isCompiledMethod.
	self assert: (object at: 6) equals: #doIt.
	self assert: (object at: 7) equals: nil.

	
	
	
