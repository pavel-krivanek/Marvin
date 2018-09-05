Class {
	#name : #MarvinPrototypeTestWithArray,
	#superclass : #TestCase,
	#instVars : [
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeTestWithArray >> checkArrayContent [

	self assert: (object _PrimitiveAt: 1) equals: 1.
	self assert: (object _PrimitiveAt: 2) equals: 2.
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> setUp [

	super setUp.
	
	object := MarvinPrototype new: 2.
	object _PrimitiveAt: 1 put: 1.
	object _PrimitiveAt: 2 put: 2.
]

{ #category : #running }
MarvinPrototypeTestWithArray >> testAddAssignSlotSlot [

	object _AddAssignSlot: #data value: 42.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 8.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: 42.
	self assert: (object _PrimitiveAt: 5) equals: #data:.
	self assert: (object _PrimitiveAt: 6) equals: #data.
	self assert: (object _PrimitiveAt: 7) equals: nil.
	self assert: (object _PrimitiveAt: 8) equals: nil.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> testAddMethod [

	object _AddMethod: 'doIt ^ 3+4'.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 7.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) isCompiledMethod.
	self assert: (object _PrimitiveAt: 6) equals: #doIt.
	self assert: (object _PrimitiveAt: 7) equals: nil.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> testAddParentSlot [

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

	self checkArrayContent.

	self assert: object _PrimitiveSize equals: 8.	
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	self assert: (object _PrimitiveAt: 6) equals: parent.
	self assert: (object _PrimitiveAt: 7) equals: #parent.
	self assert: (object _PrimitiveAt: 8) equals: #parent.
	
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> testAddReadSlot [

	object _AddReadSlot: #data value: 42.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 8.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: 42.
	self assert: (object _PrimitiveAt: 5) equals: #data.
	self assert: (object _PrimitiveAt: 6) equals: #data.
	self assert: (object _PrimitiveAt: 7) equals: nil.
	self assert: (object _PrimitiveAt: 8) equals: nil.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> testAddReadWriteParentSlot [

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parent value: parent.

	self checkArrayContent.
	
	self assert: object _PrimitiveSize equals: 8.
		
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	self assert: (object _PrimitiveAt: 6) equals: parent.
	self assert: (object _PrimitiveAt: 7) equals: #parent:.
	self assert: (object _PrimitiveAt: 8) equals: #parent.
	
	
	

]

{ #category : #running }
MarvinPrototypeTestWithArray >> testNoSlots [

	self checkArrayContent.

	self assert: object _PrimitiveSize equals: 5.
	
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	
	
	

]
