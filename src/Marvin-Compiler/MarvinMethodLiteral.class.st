Class {
	#name : #MarvinMethodLiteral,
	#superclass : #MarvinLiteral,
	#instVars : [
		'slots',
		'context'
	],
	#category : 'Marvin-Compiler-Literals'
}

{ #category : #'as yet unclassified' }
MarvinMethodLiteral >> acceptArgumetsNamed: names [

	self slots addAll: (names collect: [ :argName |
		MarvinSlotLiteral new
				name: argName;	
				type: #argumentSlot ]).



]

{ #category : #accessing }
MarvinMethodLiteral >> context [
	^context
]

{ #category : #accessing }
MarvinMethodLiteral >> context: anObject [
	context := anObject
]

{ #category : #'as yet unclassified' }
MarvinMethodLiteral >> initialize [

	super initialize.

	slots := OrderedCollection new.
	context := MarvinContext  new.
	context addInstruction: (context generator instrReturnImplicit ).

]

{ #category : #accessing }
MarvinMethodLiteral >> isMethodLiteral [

	^ true
]

{ #category : #'as yet unclassified' }
MarvinMethodLiteral >> numArguments [

	^ (self slots select: [ :slot | slot type = #argumentSlot ]) size.

]

{ #category : #accessing }
MarvinMethodLiteral >> slots [
	^slots
]

{ #category : #accessing }
MarvinMethodLiteral >> slots: anObject [
	slots := anObject
]
