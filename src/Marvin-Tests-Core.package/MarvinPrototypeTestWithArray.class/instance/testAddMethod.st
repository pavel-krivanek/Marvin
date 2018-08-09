running
testAddMethod

	object AddMethod: 'doIt ^ 3+4'.

	self checkArrayContent.
	
	self assert: object PrimitiveSize equals: 7.
		
	self assert: (object PrimitiveAt: 3) equals: nil.
	self assert: (object PrimitiveAt: 4) equals: nil.
	self assert: (object PrimitiveAt: 5) isCompiledMethod.
	self assert: (object PrimitiveAt: 6) equals: #doIt.
	self assert: (object PrimitiveAt: 7) equals: nil.

	
	
	
