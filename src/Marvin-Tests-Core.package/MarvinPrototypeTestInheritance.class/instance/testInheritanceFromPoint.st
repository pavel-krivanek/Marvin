tests
testInheritanceFromPoint

	object AddInheritance: #parent from: Point.
	object setX: 0 setY: 0.
	
	self assert: object x equals: 0.
	self assert: object y equals: 0.
	object setX: 1 setY: 2.
	self assert: object x equals: 1.
	self assert: object y equals: 2.
	self assert: object transposed equals: 2@1.