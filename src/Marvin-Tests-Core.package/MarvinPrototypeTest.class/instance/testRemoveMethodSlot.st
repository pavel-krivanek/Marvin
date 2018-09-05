tests
testRemoveMethodSlot

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.	
	object _AddMethodSlot: #DoIt value: compiledMethod.
	object _RemoveSlot: #DoIt.
	self should: [ object DoIt ] raise: MessageNotUnderstood.