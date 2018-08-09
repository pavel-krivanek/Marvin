tests
testInheritanceFromPointWithParent

	| parent |
	
	parent := MarvinPrototype new.
	parent AddMethod: 'doIt ^ (self x+self y) negated'.
	object AddParentSlot: #parent value: parent.
	object AddInheritance: #point from: Point.
	object setX: 1 setY: 2.
	
	self assert: object doIt equals: -3