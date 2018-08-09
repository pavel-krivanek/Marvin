running
checkArrayContent

	self assert: object primitiveSize equals: 19.

	self assert: (object at: 1) equals: 1.
	self assert: (object at: 2) equals: 2.
	
	self assert: (object at: 3) equals: nil.
	self assert: (object at: 4) equals: 7.
	self assert: (object at: 5) equals: #builtInData2:.
	self assert: (object at: 6) equals: #builtInData2.
	self assert: (object at: 7) equals: 42.
	self assert: (object at: 8) equals: #builtInData.
	self assert: (object at: 9) equals: #builtInData.
	self assert: (object at: 10) equals: nil.
	self assert: (object at: 11) equals: compiledMethod.
	self assert: (object at: 12) equals: #builtInMethod.
	self assert: (object at: 13) equals: nil.
	self assert: (object at: 14) equals: parent2.
	self assert: (object at: 15) equals: #builtInParent2:.
	self assert: (object at: 16) equals: #builtInParent2.
	self assert: (object at: 17) equals: parent.
	self assert: (object at: 18) equals: #builtInParent.
	self assert: (object at: 19) equals: #builtInParent.
	
	