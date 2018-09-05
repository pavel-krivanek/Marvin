Class {
	#name : #MarvinPrototypeTestInjection,
	#superclass : #TestCase,
	#instVars : [
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeTestInjection >> testInjection [

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

]

{ #category : #running }
MarvinPrototypeTestInjection >> testRevertInjection [

	object := MarvinPrototype inject: 1@2.
	object _AddAssignSlot: #y value: 5.
	
	self assert: object class equals: Point.
	self assert: object y equals: 5.
	
	object _RevertInjection.
	
	self assert: object class equals: Point.
	self assert: object y equals: 2.

]
