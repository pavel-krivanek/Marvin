tests
testInheritanceFromPointWithParent

	| parent |
	
	parent := MarvinPrototype new.
	parent _AddMethod: 'doIt ^ (self x+self y) negated'.
	object _AddParentSlot: #parent value: parent.
	object _AddInheritance: #point from: Point.
	object setX: 1 setY: 2.
	
	self assert: object doIt equals: -3