"
p1 := MarvinPrototype new.
p1 AddAssignSlot: #pData value: 12.
p1 AddAssignSlot: #data value: 1.
p1 AddMethod: 'pMsg1 
	self data: 64 + self pData.
	'.

p2 := MarvinPrototype new.
p2 AddMethod: 'pMsg2
	^ self pMsg1'.

p3 := MarvinPrototype new.
p3 AddParentSlot: #parent value: p2.

o := MarvinPrototype new.
o AddAssignSlot: #data value: 12.
o AddParentSlot: #parent value: p3.
o AddParentSlot: #parent value: p1.
o AddMethod: 'msg 
	self pMsg2.
	^ self data'.
	
o msg.


parent := MarvinPrototype new.
parent AddAssignSlot: #parentData value: 1.
parent AddMethod: 'msg 
	^ self data'.
	
o := MarvinPrototype new.
o AddParentSlot: #parent value: parent.
o AddAssignSlot: #data value: 2.

o AddMethod: 'msg 
	^ self data + self parentData + super msg'.

o msg.





"
Class {
	#name : #MarvinPrototype,
	#superclass : #MarvinPrototypeSuperclass,
	#type : #variable,
	#classInstVars : [
		'lobby',
		'DNU'
	],
	#category : 'Marvin-Core'
}

{ #category : #private }
MarvinPrototype class >> DNU [

	"an Object used as method return value indicating failure in slot lookup"

	^ DNU ifNil: [ DNU := Object new ]
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> SmalltalkObject: selector [

	 ^ Smalltalk at: selector
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> basicNew: anInteger [

	^ super basicNew: anInteger 
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> createLobby [
	
	" MarvinPrototype createLobby "

	| globals |

	lobby := MarvinPrototype new.

	globals := MarvinPrototype new.
	globals _AddReadSlot: #lobby value: lobby.
	globals _AddReadSlot: #nil value: nil.
	globals _AddReadSlot: #true value: true.
	globals _AddReadSlot: #false value: false.

	lobby _AddParentSlot: #globals value: globals.

	lobby _AddMethodSlot: #DoIt value: CompiledMethod toReturnSelf.
	lobby _AddMethodSlot: #slotNotFound: value: (MarvinPrototype class >> #lobbyDNU:).
	lobby _AddMethodSlot: #St: value: (MarvinPrototype class >> #SmalltalkObject:).

]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> inject: anObject [

	| newObject |
	
	newObject := MarvinPrototype new.
	^ newObject _Inject: anObject
	
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> injectArray: anObject [

	| newObject |
	
	newObject := MarvinPrototype new.
	^ newObject _InjectArray: anObject
	
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> lobby [

	^ lobby ifNil: [ lobby := self createLobby  ]
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> lobbyDNU: aMessage [

	 ^ Smalltalk at: aMessage selector 
		ifAbsent: [ 
			MessageNotUnderstood new 
				message: aMessage;
				receiver: self;
				signal.
			aMessage sentTo: self.]
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> new [

	^ super new: 3
]

{ #category : #'as yet unclassified' }
MarvinPrototype class >> new: anInteger [

	^ super new: 3 + anInteger
]

{ #category : #private }
MarvinPrototype class >> withAll: obj [

	| n |
	n := super new: obj size.
	1 to: obj size do: [ :i | n _PrimitiveAt: i put: (obj at: i) ].
	^ n.

]

{ #category : #support }
MarvinPrototype >> = anObject [ 

	| result |
	
	result := self _PerformMessage: (Message selector: #= argument: anObject) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self == anObject  ]
		ifFalse: [ result ]

]

{ #category : #slots }
MarvinPrototype >> _AddAssignSlot: slotName value: obj [

	| newPrototype a b |

	slotName ifNil: [ Error new signal: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self size + 3.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a-3. 
			b := b-3.].

	a := a - 1.
	b := b - 1.

	" method slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			a := a - 2. 
			b := b - 2.].

	a := a - 1.
	b := b - 1.

	" data slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3. 
			b := b - 3.].

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: (slotName, ':') asSymbol.
	newPrototype _PrimitiveAt: b-2 put: obj.

	b := b - 3.

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

]

{ #category : #slots }
MarvinPrototype >> _AddInheritance: slotName from: aBehavior [

	self _AddParentSlot: slotName value: aBehavior.
	self _AllocateDataFor: aBehavior.

]

{ #category : #slots }
MarvinPrototype >> _AddMethod: aSourceCode [

	| compiledMethod |
	
	compiledMethod := OpalCompiler new 
		class: MarvinPrototype;
		source: aSourceCode;
		failBlock: [ ^ nil ];
		compile.
		
	compiledMethod propertyAt: #owningObject put: self.
	
	^ self _AddMethodSlot: compiledMethod selector value: compiledMethod
]

{ #category : #slots }
MarvinPrototype >> _AddMethodSlot: slotName value: method [

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self _PrimitiveSize + 2.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3.
			b := b - 3 ].

	a := a - 1.
	b := b - 1.
	
	" method slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			a := a - 2. 
			b := b - 2.].


	" add slot "

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: method.
	b := b - 2.

	"rest "	

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

]

{ #category : #slots }
MarvinPrototype >> _AddParentSlot: slotName value: obj [

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self _PrimitiveSize + 3.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3. 
			b := b - 3.].
	
	" add slot "

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: slotName.
	newPrototype _PrimitiveAt: b-2 put: obj.

	b := b - 3.

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

]

{ #category : #slots }
MarvinPrototype >> _AddReadSlot: slotName value: obj [

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self _PrimitiveSize + 3.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3. 
			b := b - 3.].

	a := a - 1.
	b := b - 1.

	" method slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			a := a - 2. 
			b := b - 2.].

	a := a-1.
	b := b-1.

	" data slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3. 
			b := b - 3.].

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: slotName.
	newPrototype _PrimitiveAt: b-2 put: obj.

	b := b - 3.

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

]

{ #category : #slots }
MarvinPrototype >> _AddReadWriteParentSlot: slotName value: obj [

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self _PrimitiveSize + 3.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3. 
			b := b - 3.].
	
	" add slot "

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: (slotName, ':') asSymbol.
	newPrototype _PrimitiveAt: b-2 put: obj.

	b := b - 3.

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

]

{ #category : #data }
MarvinPrototype >> _AllocateDataFor: aBehavior [

	| newObject instSize |
	
	instSize := aBehavior instSize.

	newObject := MarvinPrototype basicNew: self _PrimitiveSize + instSize.
	
	1 to: self _PrimitiveSize do: [ :index | newObject _PrimitiveAt: instSize + index put: (self _PrimitiveAt: index) ].

	self become: newObject.

]

{ #category : #data }
MarvinPrototype >> _AllocateDataForArray: anArray [

	| newObject instSize |
	
	instSize := anArray size.

	newObject := MarvinPrototype basicNew: self _PrimitiveSize + instSize.
	
	1 to: self _PrimitiveSize do: [ :index | newObject _PrimitiveAt: instSize + index put: (self _PrimitiveAt: index) ].

	self become: newObject.

]

{ #category : #data }
MarvinPrototype >> _FillFrom: anObject [
	
	1 to: anObject class instSize do: [ :index |
		self _PrimitiveAt: index put: (anObject _PrimitiveAt: index )].


]

{ #category : #data }
MarvinPrototype >> _FillFromArray: anObject [
	
	1 to: anObject size do: [ :index |
		self _PrimitiveAt: index put: (anObject _PrimitiveAt: index )].


]

{ #category : #data }
MarvinPrototype >> _Inject: anObject [

	self _AddInheritance: #class from: anObject class.
	self _FillFrom: anObject.
	
	anObject becomeForward: self.
	^ self.
	
]

{ #category : #data }
MarvinPrototype >> _InjectArray: anObject [

	self _AddParentSlot: #class value: anObject class.
	self _AllocateDataForArray: anObject.
	self _FillFromArray: anObject.
	
	anObject becomeForward: self.
	^ self.
	
]

{ #category : #slots }
MarvinPrototype >> _RemoveSlot: slotName [ 

	| newPrototype a b found |

	a := self _PrimitiveSize.
	b := self _PrimitiveSize.
	found := false.
		
	newPrototype := Array basicNew: self _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	a := a - 1.
	newPrototype _PrimitiveAt: b put: nil.
	b := b - 1.
	
	" message slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 2. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					a := a - 2. 
					b := b - 2.] ].
	
	a := a - 1.
	newPrototype _PrimitiveAt: b put: nil.
	b := b - 1.

	" data slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	found ifFalse: [ MarvinSlotNotFound signal ].

	self become: (MarvinPrototype withAll: (newPrototype copyFrom: b-a+1 to: self _PrimitiveSize)).


]

{ #category : #data }
MarvinPrototype >> _RevertInjection [

	| aClass replacement |
	
	aClass := self class.
	replacement := aClass basicNew.
	1 to: aClass instSize do: [ :index |
		replacement _PrimitiveAt: index put: (self _PrimitiveAt: index )].
		
	"replacement becomeForward: self."
	self becomeForward: replacement.
	^ self.
	
]

{ #category : #support }
MarvinPrototype >> class [

	| result |
	
	result := self _PerformMessage: (Message selector: #class) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ super class ]
		ifFalse: [ result ]

]

{ #category : #'reflective operations' }
MarvinPrototype >> doesNotUnderstand: aMessage [ 

	| result |
	
	result := self _PerformMessage: aMessage inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

]

{ #category : #support }
MarvinPrototype >> gtInspectorActions [


[ | result |
	
	result := self PerformMessage: (Message selector: #gtInspectorActions) inContextOf: self.
	
		
	^ result == MarvinPrototype DNU 
		ifTrue: [ 
				| all |
	all := (Pragma
		allNamed: #gtInspectorAction
		from: self class
		to: ProtoObject)
		collect: [ :eachPragma | 
			result := self PerformMessage: (Message selector: eachPragma methodSelector) inContextOf: self.
			(result = MarvinPrototype DNU) ifTrue: [ 
				GLMAction new ]
			"thisContext
				object: self
				perform: eachPragma methodSelector
				withArguments: #()
				inClass: MarvinPrototype" ].
	^ all
		asSortedCollection: [ :a :b | 
			| first second |
			first := a isCategorized
				ifTrue: [ a category , a title ]
				ifFalse: [ a title ].
			second := b isCategorized
				ifTrue: [ b category , b title ]
				ifFalse: [ b title ].
			first < second ]
			
			 ]
		ifFalse: [ result ]
 ].
	^ {  }
]

{ #category : #support }
MarvinPrototype >> gtInspectorItemsIn: composite [
	<removed_gtInspectorPresentationOrder: 0> 
	^ composite table
		title: 'Slots';
		display: [ {} ];
		column: 'Name' evaluated: [ :each | 'each name' ];
		column: 'Value' evaluated: [ :each | 'each value asString' ]
]

{ #category : #support }
MarvinPrototype >> gtInspectorPresentationsFromPragmas: aCollection In: composite inContext: aGTInspector [

	aCollection
		do: [ :eachPragma | 
			eachPragma methodSelector numArgs = 0
				ifTrue: [ | presentationSource |
					presentationSource := self perform: eachPragma selector.
					presentationSource glmPresentation
						cull: composite
						cull: aGTInspector
						cull: self ].
			eachPragma methodSelector numArgs = 1
				ifTrue: [ 
					| result aMessage |
					
					aMessage := Message selector: eachPragma methodSelector arguments: {composite}.

					result := self _PerformMessage: aMessage inContextOf: self.
					(result = MarvinPrototype DNU) ifTrue: [ thisContext
						object: self
						perform: eachPragma methodSelector
						withArguments: {composite}
						inClass: MarvinPrototype ]
					"thisContext
						object: self
						perform: eachPragma methodSelector
						withArguments: {composite}
						inClass: self class" ].
			eachPragma methodSelector numArgs = 2
				ifTrue: [ thisContext
						object: self
						perform: eachPragma methodSelector
						withArguments:
							{composite.
							aGTInspector}
						inClass: self class ] ]
]

{ #category : #support }
MarvinPrototype >> gtInspectorRawIn: composite [
	"This is the most basic presentation showing the state of the object"

	| result |
	
	result := self _PerformMessage: (Message selector: #gtInspectorRawIn: argument: composite) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ composite custom: GTObjectVariablesBrowser new ]
		ifFalse: [ result ]

]

{ #category : #support }
MarvinPrototype >> gtInspectorVariableNodesIn: aCollection [
	"This is a helper method that adds to the given collection all nodes modeling named and 
	indexed attributes for the current object.
	Subclasses can override it to specialize what appears in the variables presentation."
	| indexableDisplayLimit top bottom topLimit bottomLimit |
	
	indexableDisplayLimit := GTInspector indexableDisplayLimit.        
	top := 1.
	bottom := self _PrimitiveSize.
	topLimit    := indexableDisplayLimit min: bottom.
	bottomLimit := indexableDisplayLimit max: (bottom - indexableDisplayLimit).

	top to: topLimit do: [ :index | 
		aCollection add: (GTInspectorIndexedNode hostObject: self index: index) ].
	
	bottomLimit + 1 to: bottom do: [ :index |
		aCollection add: (GTInspectorIndexedNode hostObject: self index: index) ].
	
	aCollection
		addAll: ((self class allSlots collect: [ :slot | 
			GTInspectorSlotNode hostObject: self slot: slot ]))
]

{ #category : #support }
MarvinPrototype >> hash [

	| result |
	
	result := self _PerformMessage: (Message selector: #hash) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self identityHash ]
		ifFalse: [ result ]

]

{ #category : #support }
MarvinPrototype >> inspect [
	"Create and schedule an Inspector in which the user can examine the receiver's variables."

	| result |
	
	result := self _PerformMessage: (Message selector: #inspect) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ Smalltalk tools inspector inspect: self ]
		ifFalse: [ result ]
]

{ #category : #support }
MarvinPrototype >> isKindOf: aClass [

	| result |
	
	result := self _PerformMessage: (Message selector: #isKindOf argument: aClass) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self class == aClass
			ifTrue: [^true]
			ifFalse: [^self class inheritsFrom: aClass] ]
		ifFalse: [ result ]


]

{ #category : #support }
MarvinPrototype >> isString [

	| result |
	
	result := self _PerformMessage: (Message selector: #isString) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ false]
		ifFalse: [ result ]


]

{ #category : #support }
MarvinPrototype >> printOn: aStream [

	| result |
	
	result := self _PerformMessage: (Message selector: #printOn: argument: aStream) inContextOf: self.
	
	result == MarvinPrototype DNU 
		ifTrue: [ aStream << 'aMarvinPrototype' ]
		ifFalse: [ result ]

]

{ #category : #support }
MarvinPrototype >> printString [

	| result |
	
	result := self _PerformMessage: (Message selector: #printString) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ 'aMarvinPrototype' ]
		ifFalse: [ result ]

]

{ #category : #support }
MarvinPrototype >> size [

	| result |
	
	result := self _PerformMessage: (Message selector: #size) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self _PrimitiveSize ]
		ifFalse: [ result ]

]

{ #category : #'reflective operations' }
MarvinPrototype >> slotNotFound: aMessage [

	MessageNotUnderstood new 
		message: aMessage;
		receiver: self;
		signal.
	^ aMessage sentTo: self.
]

{ #category : #support }
MarvinPrototype >> ~= anObject [ 

	| result |
	
	result := self _PerformMessage: (Message selector: #~= argument: anObject) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self = anObject == false ]
		ifFalse: [ result ]
]
