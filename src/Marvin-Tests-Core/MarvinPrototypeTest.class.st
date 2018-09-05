Class {
	#name : #MarvinPrototypeTest,
	#superclass : #TestCase,
	#instVars : [
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeTest >> setUp [

	super setUp.
	
	object := MarvinPrototype new.

]

{ #category : #tests }
MarvinPrototypeTest >> testAddAssignSlotSlot [

	object _AddAssignSlot: #data value: 42.

	self assert: object data equals: 42.
	self assert: (object data: 12) equals: object.
	self assert: object data equals: 12.
]

{ #category : #tests }
MarvinPrototypeTest >> testAddMethod [

	object _AddMethod: 'doIt ^ 3+4'.
	self assert: object doIt equals: 3+4.
]

{ #category : #tests }
MarvinPrototypeTest >> testAddMethodSlot [

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.
	
	object _AddMethodSlot: #doIt value: compiledMethod.
	self assert: object doIt equals: object.
]

{ #category : #tests }
MarvinPrototypeTest >> testAddParentSlot [

	|  parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	self should: [ object parent: parent ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeTest >> testAddReadSlot [

	object _AddReadSlot: #data value: 42.

	self assert: object data equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeTest >> testAddReadWriteParentSlot [

	|  parent parent2 |
	
	parent := MarvinPrototype new.
	parent2 := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parent value: parent.

	self assert: object parent equals: parent.
	self assert: (object parent: parent2) equals: object.
	self assert: object parent equals: parent2.
	
]

{ #category : #tests }
MarvinPrototypeTest >> testEmpty [

	self should: [ object data ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeTest >> testReadSlotHiding [

	| parent |
	
	parent := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

	parent _AddAssignSlot: #data value: 12.
	object _AddAssignSlot: #data value: 1.
	
	self assert: object data equals: 1.
]

{ #category : #tests }
MarvinPrototypeTest >> testRemoveAssignSlot [

	object _AddAssignSlot: #data value: 42.
	object _RemoveSlot: #data.
	self should: [ object data ] raise: MessageNotUnderstood. 
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeTest >> testRemoveMethodSlot [

	| compiledMethod |
	
	compiledMethod := CompiledMethod toReturnSelf.	
	object _AddMethodSlot: #DoIt value: compiledMethod.
	object _RemoveSlot: #DoIt.
	self should: [ object DoIt ] raise: MessageNotUnderstood.
]

{ #category : #tests }
MarvinPrototypeTest >> testRemoveReadSlot [

	object _AddReadSlot: #data value: 42.
	object _RemoveSlot: #data.
	self should: [ object data ] raise: MessageNotUnderstood. 
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeTest >> testRemoveUnknown [

	self should: [ object _RemoveSlot: #data ] raise: MessageNotUnderstood. 
	
]
