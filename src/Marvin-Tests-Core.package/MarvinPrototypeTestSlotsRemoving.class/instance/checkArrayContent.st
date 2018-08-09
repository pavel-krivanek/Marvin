running
checkArrayContent

	self assert: object primitiveSize equals: 5.

	self assert: (object at: 1) equals: 1.
	self assert: (object at: 2) equals: 2.
	
	self assert: (object at: 3) equals: nil.
	self assert: (object at: 4) equals: nil.
	self assert: (object at: 5) equals: nil.
	
	
