Class {
	#name : #MarvinPrototypeTestInheritance,
	#superclass : #TestCase,
	#instVars : [
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #tests }
MarvinPrototypeTestInheritance >> setUp [

	super setUp.
	
	object := MarvinPrototype new.

]

{ #category : #tests }
MarvinPrototypeTestInheritance >> testInheritanceFromPoint [

	object _AddInheritance: #parent from: Point.
	object setX: 0 setY: 0.
	
	self assert: object x equals: 0.
	self assert: object y equals: 0.
	object setX: 1 setY: 2.
	self assert: object x equals: 1.
	self assert: object y equals: 2.
	self assert: object transposed equals: 2@1.
]

{ #category : #tests }
MarvinPrototypeTestInheritance >> testInheritanceFromPointWithParent [

	| parent |
	
	parent := MarvinPrototype new.
	parent _AddMethod: 'doIt ^ (self x+self y) negated'.
	object _AddParentSlot: #parent value: parent.
	object _AddInheritance: #point from: Point.
	object setX: 1 setY: 2.
	
	self assert: object doIt equals: -3
]
