tests
testRemoveAssignSlot

	| object |
	
	object := MarvinPrototype new.
	object AddAssignSlot: #data value: 42.
	object RemoveSlot: #data.
	self should: [ object data ] raise: MarvinSlotNotFound. 
	self should: [ object data: 12 ] raise: MarvinSlotNotFound. 
	