tests
testRemoveMethodSlot

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.	
	object AddMethodSlot: #DoIt value: compiledMethod.
	object RemoveSlot: #DoIt.
	self should: [ object DoIt ] raise: MessageNotUnderstood.