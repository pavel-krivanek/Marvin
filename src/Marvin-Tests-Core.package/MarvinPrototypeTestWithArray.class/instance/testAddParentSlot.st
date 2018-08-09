running
testAddParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

	self checkArrayContent.

	self assert: object primitiveSize equals: 8.	
	self assert: (object at: 3) equals: nil.
	self assert: (object at: 4) equals: nil.
	self assert: (object at: 5) equals: nil.
	self assert: (object at: 6) equals: parent.
	self assert: (object at: 7) equals: #parent.
	self assert: (object at: 8) equals: #parent.
	
	
	
