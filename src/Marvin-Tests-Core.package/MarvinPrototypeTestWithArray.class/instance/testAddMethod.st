running
testAddMethod

	object _AddMethod: 'doIt ^ 3+4'.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 7.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) isCompiledMethod.
	self assert: (object _PrimitiveAt: 6) equals: #doIt.
	self assert: (object _PrimitiveAt: 7) equals: nil.

	
	
	
