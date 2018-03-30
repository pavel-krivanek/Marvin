tests
testAddMethodSlot

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.
	
	object AddMethodSlot: #doIt value: compiledMethod.
	self assert: object doIt equals: object.