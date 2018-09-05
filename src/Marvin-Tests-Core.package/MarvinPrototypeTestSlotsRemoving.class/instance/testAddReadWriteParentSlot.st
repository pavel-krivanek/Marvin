running
testAddReadWriteParentSlot
	
	|  parent |
	
	parent := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parent value: parent.
	object _RemoveSlot: #parent.

	self checkArrayContent.

	
	
	
