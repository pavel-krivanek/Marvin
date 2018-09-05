running
checkArrayContent

	self assert: object _PrimitiveSize equals: 5.

	self assert: (object _PrimitiveAt: 1) equals: 1.
	self assert: (object _PrimitiveAt: 2) equals: 2.
	
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	
	
