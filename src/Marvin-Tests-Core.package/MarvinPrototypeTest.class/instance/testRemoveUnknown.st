tests
testRemoveUnknown

	self should: [ object _RemoveSlot: #data ] raise: MessageNotUnderstood. 
	