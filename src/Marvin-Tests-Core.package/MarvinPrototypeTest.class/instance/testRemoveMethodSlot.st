tests
testRemoveMethodSlot

	| object compiledMethod |
	
	object := MarvinPrototype new.
	compiledMethod := CompiledMethod toReturnSelf.	
	object AddMethodSlot: #DoIt value: compiledMethod.
	object RemoveSlot: #DoIt.
	self should: [ object DoIt ] raise: MarvinSlotNotFound.