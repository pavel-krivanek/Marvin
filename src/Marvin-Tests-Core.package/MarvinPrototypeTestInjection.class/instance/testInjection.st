running
testInjection

	| parent objectToExtend |
	
	objectToExtend := 1@2.

	parent := MarvinPrototype new.
	parent _AddMethod: 'testingMethod ^ self x - self y + self testingValue'.
	parent _AddAssignSlot: #y value: 5.
	parent _AddReadSlot: #testingValue value: 42.

	object := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.
	object _Inject: objectToExtend.
	object _AddReadSlot: #testingValue value: 3.

	self assert: object testingMethod equals: -1.
