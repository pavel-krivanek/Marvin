tests
testRemoveReadSlot

	object AddReadSlot: #data value: 42.
	object RemoveSlot: #data.
	self should: [ object data ] raise: MessageNotUnderstood. 
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	