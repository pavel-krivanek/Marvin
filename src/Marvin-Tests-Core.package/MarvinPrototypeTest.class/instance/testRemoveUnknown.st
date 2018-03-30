tests
testRemoveUnknown

	self should: [ object RemoveSlot: #data ] raise: MessageNotUnderstood. 
	