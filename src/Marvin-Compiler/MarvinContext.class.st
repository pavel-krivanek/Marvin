Class {
	#name : #MarvinContext,
	#superclass : #Object,
	#instVars : [
		'literals',
		'selectors',
		'instructions'
	],
	#category : 'Marvin-Compiler'
}

{ #category : #'as yet unclassified' }
MarvinContext >> + aContext [

	literals addAll: aContext literals.
	selectors addAll: aContext selectors.
	instructions addAll: aContext instructions
]

{ #category : #'as yet unclassified' }
MarvinContext >> addInstruction: anInstruction [

	instructions add: anInstruction

]

{ #category : #'as yet unclassified' }
MarvinContext >> addLiteral: object [  

	| literal |

	object isConstantLiteral ifTrue: [ 
		literal := object content ].

	^ literals 
		indexOf: literal 
		ifAbsent: [literals add: literal. literals indexOf: literal].

]

{ #category : #'as yet unclassified' }
MarvinContext >> addSelector: object [  

	| symbol |
	
	symbol := object asSymbol.

	^ selectors 
		indexOf: symbol 
		ifAbsent: [selectors add: symbol. selectors indexOf: symbol].

]

{ #category : #accessing }
MarvinContext >> code [

	^ ''
]

{ #category : #accessing }
MarvinContext >> generator [

	^ MarvinBytecodeGenerator 
]

{ #category : #'as yet unclassified' }
MarvinContext >> initialize [

	literals := OrderedCollection new.
	selectors := OrderedCollection new.
	instructions := OrderedCollection new.

]

{ #category : #accessing }
MarvinContext >> instructions [

	^ instructions
]

{ #category : #accessing }
MarvinContext >> literals [
	^literals
]

{ #category : #accessing }
MarvinContext >> literals: anObject [
	literals := anObject
]

{ #category : #printing }
MarvinContext >> printOn: aStream [

	aStream 
		nextPutAll: 'Object ('.

	aStream 
		tab; nextPutAll: 'Literals:'; cr..
	self literals do: [:literal | aStream tab; tab. literal printOn: aStream. aStream cr. ].
	
	aStream 
		tab; nextPutAll: 'Instructions:'; cr.
	self instructions do: [:instruction | aStream tab; tab. instruction printOn: aStream. aStream cr.].
]

{ #category : #accessing }
MarvinContext >> regenerate [

	literals = OrderedCollection new.
	selectors = OrderedCollection new..

	instructions do: [ :i |
		
		i first = #pushLiteral: 
			ifTrue: [ self addLiteral: i second ]. 
			
		(i first = #send:)
			ifTrue: [ self addSelector: i second ].
			 
		(i first = #resend:)
			ifTrue: [ self addSelector: i second ].

		(i first = #selfSend:)
			ifTrue: [ self addSelector: i second ].
	].
]

{ #category : #accessing }
MarvinContext >> selectors [
	^selectors
]

{ #category : #accessing }
MarvinContext >> selectors: anObject [
	selectors := anObject
]
