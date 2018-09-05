running
testAddParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.
	object _RemoveSlot: #parent.

	self checkArrayContent.

	
	
	
