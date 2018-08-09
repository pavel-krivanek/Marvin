running
checkArrayContent

	self assert: object PrimitiveSize equals: 5.

	self assert: (object PrimitiveAt: 1) equals: 1.
	self assert: (object PrimitiveAt: 2) equals: 2.
	
	self assert: (object PrimitiveAt: 3) equals: nil.
	self assert: (object PrimitiveAt: 4) equals: nil.
	self assert: (object PrimitiveAt: 5) equals: nil.
	
	
