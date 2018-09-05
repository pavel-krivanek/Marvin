running
testAddReadWriteParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parent value: parent.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 8.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	self assert: (object _PrimitiveAt: 6) equals: parent.
	self assert: (object _PrimitiveAt: 7) equals: #parent:.
	self assert: (object _PrimitiveAt: 8) equals: #parent.
	
	
	
