Class {
	#name : #MarvinPrototypeResendTest,
	#superclass : #TestCase,
	#instVars : [
		'parent',
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeResendTest >> setUp [

	super setUp.

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

]

{ #category : #tests }
MarvinPrototypeResendTest >> testResendHiddenReadSlot [

	parent _AddReadSlot: #data value: 42.
	parent _AddReadSlot: #data value: 1.

	object _AddMethod: 'doIt ^ super data'.

	self assert: object data equals: 42.
	
]

{ #category : #tests }
MarvinPrototypeResendTest >> testResendReadSlot [

	parent _AddReadSlot: #parentData value: 42.
	parent _AddReadSlot: #data value: 1.

	object _AddMethod: 'doIt ^ super parentData'.

	self assert: object doIt equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeResendTest >> testSuperInDelegation [

	parent _AddMethod: 'doIt ^ super'.

	self assert: object doIt equals: object.
]
