running
setUp
	
	super setUp.
	
	parent := MarvinPrototype new.
	parent2 := MarvinPrototype new.

	object := MarvinPrototype new: 2.
	object _PrimitiveAt: 1 put: 1.
	object _PrimitiveAt: 2 put: 2.
	
	object _AddParentSlot: #builtInParent value: parent.
	object _AddReadWriteParentSlot: #builtInParent2 value: parent2.

	compiledMethod := CompiledMethod toReturnSelf.
	object _AddMethodSlot: #builtInMethod value: compiledMethod.

	object _AddReadSlot: #builtInData value: 42.
	object _AddAssignSlot: #builtInData2 value: 7.

