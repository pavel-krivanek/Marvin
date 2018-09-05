running
checkArrayContent

	self assert: object _PrimitiveSize equals: 19.

	self assert: (object _PrimitiveAt: 1) equals: 1.
	self assert: (object _PrimitiveAt: 2) equals: 2.
	
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: 7.
	self assert: (object _PrimitiveAt: 5) equals: #builtInData2:.
	self assert: (object _PrimitiveAt: 6) equals: #builtInData2.
	self assert: (object _PrimitiveAt: 7) equals: 42.
	self assert: (object _PrimitiveAt: 8) equals: #builtInData.
	self assert: (object _PrimitiveAt: 9) equals: #builtInData.
	self assert: (object _PrimitiveAt: 10) equals: nil.
	self assert: (object _PrimitiveAt: 11) equals: compiledMethod.
	self assert: (object _PrimitiveAt: 12) equals: #builtInMethod.
	self assert: (object _PrimitiveAt: 13) equals: nil.
	self assert: (object _PrimitiveAt: 14) equals: parent2.
	self assert: (object _PrimitiveAt: 15) equals: #builtInParent2:.
	self assert: (object _PrimitiveAt: 16) equals: #builtInParent2.
	self assert: (object _PrimitiveAt: 17) equals: parent.
	self assert: (object _PrimitiveAt: 18) equals: #builtInParent.
	self assert: (object _PrimitiveAt: 19) equals: #builtInParent.
	
	