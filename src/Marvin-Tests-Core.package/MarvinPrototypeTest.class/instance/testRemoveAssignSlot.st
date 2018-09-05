tests
testRemoveAssignSlot

	object _AddAssignSlot: #data value: 42.
	object _RemoveSlot: #data.
	self should: [ object data ] raise: MessageNotUnderstood. 
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	