running
testAddReadSlot

	object _AddReadSlot: #data value: 42.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 8.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: 42.
	self assert: (object _PrimitiveAt: 5) equals: #data.
	self assert: (object _PrimitiveAt: 6) equals: #data.
	self assert: (object _PrimitiveAt: 7) equals: nil.
	self assert: (object _PrimitiveAt: 8) equals: nil.

	
	
	
