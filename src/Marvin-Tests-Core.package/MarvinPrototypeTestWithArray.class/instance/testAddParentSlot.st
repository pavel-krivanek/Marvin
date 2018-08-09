running
testAddParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

	self checkArrayContent.

	self assert: object PrimitiveSize equals: 8.	
	self assert: (object PrimitiveAt: 3) equals: nil.
	self assert: (object PrimitiveAt: 4) equals: nil.
	self assert: (object PrimitiveAt: 5) equals: nil.
	self assert: (object PrimitiveAt: 6) equals: parent.
	self assert: (object PrimitiveAt: 7) equals: #parent.
	self assert: (object PrimitiveAt: 8) equals: #parent.
	
	
	
