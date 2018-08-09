running
testAddReadWriteParentSlot
	
	|  parent |
	
	parent := MarvinPrototype new.
	object AddReadWriteParentSlot: #parent value: parent.
	object RemoveSlot: #parent.

	self checkArrayContent.

	
	
	
