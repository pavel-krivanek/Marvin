running
checkArrayContent

	self assert: object PrimitiveSize equals: 19.

	self assert: (object PrimitiveAt: 1) equals: 1.
	self assert: (object PrimitiveAt: 2) equals: 2.
	
	self assert: (object PrimitiveAt: 3) equals: nil.
	self assert: (object PrimitiveAt: 4) equals: 7.
	self assert: (object PrimitiveAt: 5) equals: #builtInData2:.
	self assert: (object PrimitiveAt: 6) equals: #builtInData2.
	self assert: (object PrimitiveAt: 7) equals: 42.
	self assert: (object PrimitiveAt: 8) equals: #builtInData.
	self assert: (object PrimitiveAt: 9) equals: #builtInData.
	self assert: (object PrimitiveAt: 10) equals: nil.
	self assert: (object PrimitiveAt: 11) equals: compiledMethod.
	self assert: (object PrimitiveAt: 12) equals: #builtInMethod.
	self assert: (object PrimitiveAt: 13) equals: nil.
	self assert: (object PrimitiveAt: 14) equals: parent2.
	self assert: (object PrimitiveAt: 15) equals: #builtInParent2:.
	self assert: (object PrimitiveAt: 16) equals: #builtInParent2.
	self assert: (object PrimitiveAt: 17) equals: parent.
	self assert: (object PrimitiveAt: 18) equals: #builtInParent.
	self assert: (object PrimitiveAt: 19) equals: #builtInParent.
	
	