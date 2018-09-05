Class {
	#name : #MarvinPrototypeDelegationTest,
	#superclass : #TestCase,
	#instVars : [
		'parent',
		'object'
	],
	#category : 'Marvin-Tests-Core'
}

{ #category : #running }
MarvinPrototypeDelegationTest >> setUp [

	super setUp.

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testAccessFromParent [

	parent _AddAssignSlot: #parentData value: 12.
	object _AddAssignSlot: #data value: 1.
	parent _AddMethod: 'doIt ^ self data + self parentData'.
	
	self assert: object doIt equals: 13.
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testComplexDelegation [

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
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegateAssignSlot [

	parent _AddAssignSlot: #data value: 42.

	self assert: object data equals: 42.
	self assert: (object data: 12) equals: object.
	self assert: object data equals: 12.	
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegateEmpty [

	self should: [ object data ] raise: MessageNotUnderstood. 

]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegateMethod [

	parent _AddMethod: 'doIt ^ 3+4'.

	self assert: object doIt equals: 3+4.
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegateParentSlot [

	| parentOfParent parent2 |

	parentOfParent := MarvinPrototype new.
	parent2 := MarvinPrototype new.
	object _AddReadWriteParentSlot: #parentOfParent value: parentOfParent.

	self assert: object parentOfParent equals: parentOfParent.
	self assert: (object parentOfParent: parent2) equals: object.
	self assert: object parentOfParent equals: parent2.

]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegateReadSlot [

	parent _AddReadSlot: #data value: 42.

	self assert: object data equals: 42.
	self should: [ object data: 12 ] raise: MessageNotUnderstood. 
	
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testDelegationChain [

	| parentOfParent parent2 |

	parentOfParent := MarvinPrototype new.
	parent2 := MarvinPrototype new.
	parent _AddReadWriteParentSlot: #parentOfParent value: parentOfParent.

	self assert: object parentOfParent equals: parentOfParent.
	self assert: (object parentOfParent: parent2) equals: object.
	self assert: object parentOfParent equals: parent2.

]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testSelfInDelegation [

	parent _AddMethod: 'doIt ^ self'.

	self assert: object doIt equals: object.
]

{ #category : #tests }
MarvinPrototypeDelegationTest >> testSlotHiding [

	parent _AddAssignSlot: #data value: 12.
	object _AddAssignSlot: #data value: 1.
	parent _AddMethod: 'doIt ^ self data'.
	
	self assert: object doIt equals: 1.
]
