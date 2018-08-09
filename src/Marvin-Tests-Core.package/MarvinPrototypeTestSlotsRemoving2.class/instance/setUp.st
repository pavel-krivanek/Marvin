running
setUp
	
	super setUp.
	
	parent := MarvinPrototype new.
	parent2 := MarvinPrototype new.

	object := MarvinPrototype new: 2.
	object at: 1 put: 1.
	object at: 2 put: 2.
	
	object AddParentSlot: #builtInParent value: parent.
	object AddReadWriteParentSlot: #builtInParent2 value: parent2.

	compiledMethod := CompiledMethod toReturnSelf.
	object AddMethodSlot: #builtInMethod value: compiledMethod.

	object AddReadSlot: #builtInData value: 42.
	object AddAssignSlot: #builtInData2 value: 7.

