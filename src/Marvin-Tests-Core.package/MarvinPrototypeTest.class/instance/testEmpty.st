tests
testEmpty

	self should: [ object data ] raise: MessageNotUnderstood. 
	