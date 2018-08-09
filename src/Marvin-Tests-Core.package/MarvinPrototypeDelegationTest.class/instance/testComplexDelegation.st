tests
testComplexDelegation

	| innerParent innerObject |

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.
	
	innerParent := MarvinPrototype new.
	innerParent AddMethod: 'a ^ self a'.
	innerParent AddReadSlot: #b value: 1.
	
	parent AddParentSlot: #parent value: innerParent.
	parent AddMethod: 'a ^ super a'.
	
	innerObject := 	MarvinPrototype new.
	innerObject AddReadSlot: #a value: 3.
	innerObject AddReadSlot: #b value: 4.

	object AddReadSlot: #a value: innerObject.
	object AddMethod: 'method ^ super a a'.
	
	self assert: object method equals: 3.