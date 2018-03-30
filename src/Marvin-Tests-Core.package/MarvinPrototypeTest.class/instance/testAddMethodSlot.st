tests
testAddMethodSlot

	| object compiledMethod |
	
	object := MarvinPrototype new.
	compiledMethod := CompiledMethod toReturnSelf.
	
	object AddMethodSlot: #DoIt value: CompiledMethod toReturnSelf.
	self assert: object DoIt equals: object.