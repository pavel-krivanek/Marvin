tests
testAddMethodSlot

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.
	
	object _AddMethodSlot: #doIt value: compiledMethod.
	self assert: object doIt equals: object.