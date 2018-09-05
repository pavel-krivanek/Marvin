tests
testComplexDelegation

	| innerParent innerObject |

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.
	
	innerParent := MarvinPrototype new.
	innerParent _AddMethod: 'a ^ self a'.
	innerParent _AddReadSlot: #b value: 1.
	
	parent _AddParentSlot: #parent value: innerParent.
	parent _AddMethod: 'a ^ super a'.
	
	innerObject := 	MarvinPrototype new.
	innerObject _AddReadSlot: #a value: 3.
	innerObject _AddReadSlot: #b value: 4.

	object _AddReadSlot: #a value: innerObject.
	object _AddMethod: 'method ^ super a a'.
	
	self assert: object method equals: 3.