Class {
	#name : #MarvinPrototypeTestSlotsRemoving,
	#superclass : #TestCase,
	#instVars : [
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> checkArrayContent [

	self assert: object _PrimitiveSize equals: 5.

	self assert: (object _PrimitiveAt: 1) equals: 1.
	self assert: (object _PrimitiveAt: 2) equals: 2.
	
	self assert: (object _PrimitiveAt: 3) equals: nil.
	self assert: (object _PrimitiveAt: 4) equals: nil.
	self assert: (object _PrimitiveAt: 5) equals: nil.
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> setUp [

	super setUp.
	
	object := MarvinPrototype new: 2.
	object _PrimitiveAt: 1 put: 1.
	object _PrimitiveAt: 2 put: 2.
]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testAddAssignSlotSlot [

	object _AddAssignSlot: #data value: 42.
	object _RemoveSlot: #data.

	self checkArrayContent.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testAddMethod [

	object _AddMethod: 'doIt ^ 3+4'.
	object _RemoveSlot: #doIt.

	self checkArrayContent.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testAddParentSlot [

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.
	object _RemoveSlot: #parent.

	self checkArrayContent.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testAddReadSlot [
	
	object _AddReadSlot: #data value: 42.
	object _RemoveSlot: #data.

	self checkArrayContent.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testAddReadWriteParentSlot [
	
	|  parent |
	
	parent := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parent value: parent.
	object _RemoveSlot: #parent.

	self checkArrayContent.

	
	
	

]

{ #category : #running }
MarvinPrototypeTestSlotsRemoving >> testEmpty [
	
	self checkArrayContent.

	
	
	

]
