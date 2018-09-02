running
testInjection

	| parent objectToExtend |
	
	objectToExtend := 1@2.

	parent := MarvinPrototype new.
	parent AddMethod: 'testingMethod ^ self x - self y + self testingValue'.
	parent AddReadSlot: #testingValue value: 42.

	object := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.
	object Inject: objectToExtend.
	object AddReadSlot: #testingValue value: 3.

	self assert: object testingMethod equals: 2.
