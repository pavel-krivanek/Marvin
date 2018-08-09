running
testAddParentSlot

	|  parent |
	
	parent := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.
	object RemoveSlot: #parent.

	self checkArrayContent.

	
	
	
